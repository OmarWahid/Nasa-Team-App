import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/model/chat_model.dart';
import 'package:nasa_app/model/login_model.dart';
import 'package:nasa_app/model/member_model.dart';
import 'package:nasa_app/model/posts_model.dart';
import 'package:nasa_app/network/cache_helper.dart';
import 'package:nasa_app/screens/department.dart';
import 'package:nasa_app/screens/news.dart';
import 'package:nasa_app/screens/setting.dart';
import 'package:nasa_app/shared/component.dart';
import '../../layout/home_layout.dart';
import '../../screens/login/login.dart';

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(InitialState_());

  static NasaCubit get(context) => BlocProvider.of(context);

  bool isDoneSecond = true;

  Future<void> getSomeSecond() async {
    emit(LoadingSecond());
    await Future.delayed(Duration(milliseconds: 1100));
    isDoneSecond = false;
    emit(SuccessSecond());
  }

  int currentIndex = 0;
  List<Widget> screens = [
     DepartScreen(
      scrollController: scrollController,
    ),
     NewsScreen(
      scrollController: scrollController,
    ),
    const SettingScreen(),
  ];

  void changeScreen(int index) {
    currentIndex = index;

    emit(changeIndexButton());
  }

  SocialModel? userData;

  bool isDoneUser = true;

  Future getUserData() async {
    emit(LoadingGetUserData());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userData = SocialModel.fromJson(value.data()!);

      print(FirebaseAuth.instance.currentUser!.email);
      print(userData!.name);
      print('///////////////////////////////////////////////////////');
      isDoneUser = false;
      emit(SuccessGetUserData());
    }).catchError((error) {
      emit(ErrorGetUserData(error: error.toString()));
    });
  }

  // Future getNasaMemberData(index) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc()
  //       .get()
  //       .then((value) {
  //     memberModel = MemberModel.fromJson(value.data()!);
  //     print(value.data());
  //     emit(SuccessGetNasaMemberData());
  //   }).catchError((error) {
  //     emit(ErrorGetNasaMemberData(error: error.toString()));
  //   });
  // }

  // var allData;
  // MemberTestModel? memberTestModel;
  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('users');
  //
  // bool isDoneNasa = true;
  //
  // Future getNasa() async {
  //   emit(LoadingNasaData());
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //
  //   // Get data from docs and convert map to List
  //   allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
  //   isDoneNasa = false;
  //   emit(SuccessNasaData());
  //   // memberTestModel = MemberTestModel.fromJson(allData);
  //   print(allData[0]['name']);
  // }

  void updateUserText({
    required String bio,
    required String name,
    required String phone,
  }) async {
    SocialModel socialModel = SocialModel(
      email: userData!.email,
      name: name,
      phone: phone,
      image: (imageProfileUrl == '') ? userData!.image : imageProfileUrl,
      uId: userData!.uId,
      bio: bio,
      isVar: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .update(socialModel.toJson())
        .then((value) async {
      await getUserData();
      emit(SuccessUpdateTextData());
    }).onError((error, stackTrace) {
      emit(ErrorUpdateTextData());
    });
  }

  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
        uId = '';
      });

      emit(SuccessLogoutData());
    }).catchError((error) {
      emit(ErrorLogoutData());
    });
  }

  File? profileImage;
  File? compressedImage;
  final picker = ImagePicker();

  Future<void> getProfileData() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      compressedImage = await compressAndGetFile(
        file: profileImage!,
        quality: 94,
      );

      await uploadProfile();
      emit(ProfilePikerSuccessState());
    } else {
      print('no Image ????');
      emit(ProfilePikerErrorState());
    }
  }

  Future<File> compressAndGetFile(
      {required File file, required int quality}) async {
    emit(LoadingCompressPhoto());
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: quality,
    );

    print(
        '@@@@@@@@@@@@@@@@@@@@@@@@@@ ${file.lengthSync()} @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    print(result!.lengthSync());
    return result;
  }

  String imageProfileUrl = '';

  Future<void> uploadProfile() async {

    await storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(compressedImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        imageProfileUrl = value;
        print(imageProfileUrl);
      }).onError((error, stackTrace) {
        print(error);
        emit(ErrorUploadProfileUrl());
      });
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorUploadProfileUrl());
    });
  }

  late StreamSubscription<ConnectivityResult> subscription;
  ConnectivityResult status = ConnectivityResult.mobile;

  void checkInternet() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      status = result;
      emit(CheckConnectState());
    });
  }

  String postIdTest = '';

  void getIdPostsTest(String id) {
    postIdTest = id;
    emit(GetIdPostsTest());
  }

  bool isDonePosts = true;

  List<String> postsId = [];
  List<PostModel> posts = [];

  void getPosts() {
    emit(LoadingGetPosts());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('idPost')
        .get()
        .then((value) {
      posts = [];
      for (var element in value.docs) {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      }
      isDonePosts = false;
      emit(SuccessGetPosts());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorGetPosts());
    });
  }

  // void getPosts() {
  //   emit(LoadingGetPosts());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy('idPost')
  //       .snapshots()
  //       .listen((event) {
  //     posts = [];
  //     for (var element in event.docs) {
  //       postsId.add(element.id);
  //       posts.add(PostModel.fromJson(element.data()));
  //     }
  //     isDonePosts = false;
  //     emit(SuccessGetPosts());
  //   });
  // }

  bool isLiked = false;

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.id == userData!.uId) {
          isLiked = true;
        }
      }
      print(isLiked);
      if (isLiked) {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(userData!.uId)
            .delete()
            .then((value) {
          // posts[index].like = false;
          isLiked = false;

          // FirebaseFirestore.instance
          //     .collection('posts')
          //     .doc(postId)
          //     .get()
          //     .then((value) {
          //   value.reference.update({
          //     'like': false,
          //   });
          // });

          emit(SuccessLikePosts());
        }).onError((error, stackTrace) {
          print(error);
          isLiked = false;

          emit(ErrorLikePosts());
        });
      } else {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(userData!.uId)
            .set({
          'like': true,
        }).then((value) {
          // posts[index].like = true;

          // FirebaseFirestore.instance
          //     .collection('posts')
          //     .doc(postId)
          //     .get()
          //     .then((value) {
          //   value.reference.update({
          //     'like': true,
          //   });
          // });

          // posts[index].like = true;
          emit(SuccessLikePosts());
        }).onError((error, stackTrace) {
          print(error);
          emit(ErrorLikePosts());
        });
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorLikePosts());
    });
  }

  bool isComment = false;
  CommentModel? commentModel;

  void commentPost({
    required String postId,
    required String text,
  }) {
    isComment = true;
    emit(LoadingCommentPosts());
    commentModel = CommentModel(
      name: userData!.name,
      image: userData!.image,
      text: text,
      time: DateTime.now().toString(),
      uId: userData!.uId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel!.toJson())
        .then((value) {
      isComment = false;
      emit(SuccessCommentPosts());
    }).onError((error, stackTrace) {
      print(error);
      isComment = false;
      emit(ErrorCommentPosts());
    });
  }


  Future<void> deleteComment({
    required String postId,
    required String commentId,
  }) async{
    emit(LoadingDeleteCommentPosts());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete()
        .then((value) {
      emit(SuccessDeleteCommentPosts());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorDeleteCommentPosts());
    });
  }

  Future<void> deleteMessageChat({
    required String chatId,
  }) async{
    emit(LoadingDeleteMessageChat());
    FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .delete()
        .then((value) {
      emit(SuccessDeleteMessageChat());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorDeleteMessageChat());
    });
  }

  bool isDoneEdit = false;
  void editComment({
    required String postId,
    required String commentId,
    required String text,
  }) {
    isDoneEdit = true;
    print(isDoneEdit);
    emit(LoadingEditCommentPosts());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'text': text,
    }).then((value) {
      isDoneEdit = false;
      print(isDoneEdit);

      emit(SuccessEditCommentPosts());
    }).onError((error, stackTrace) {
      print(error);
      isDoneEdit = false;
      emit(ErrorEditCommentPosts());
    });
  }


  bool isMessage = false;
  ChatModel? chatModel;

  void groupSendMessage({
    required String text,
  }) {
    isMessage = true;
    emit(LoadingGroupSendMessage());
    chatModel = ChatModel(
      senderId: userData!.uId,
      text: text,
      time:DateFormat('yyyyy.MMMMM.dd GGG h:mm:ss aaa').format(DateTime.now()),
      // DateFormat('h:mm:ss a').format(DateTime.now()).toString(),
      image: userData!.image,
      name: userData!.name,
    );
    FirebaseFirestore.instance
        .collection('chat')
        .add(
          chatModel!.toJson(),
        )
        .then((value) {
      isMessage = false;
      emit(SuccessGroupSendMessage());
    }).onError((error, stackTrace) {
      print(error);
      isMessage = false;
      emit(ErrorGroupSendMessage());
    });
  }
}
