import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/model/login_model.dart';
import 'package:nasa_app/model/member_model.dart';
import 'package:nasa_app/model/posts_model.dart';
import 'package:nasa_app/network/cache_helper.dart';
import 'package:nasa_app/screens/department.dart';
import 'package:nasa_app/screens/news.dart';
import 'package:nasa_app/screens/setting.dart';
import 'package:nasa_app/shared/component.dart';
import '../../screens/login/login.dart';

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(InitialState_());

  static NasaCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;
  bool isDoneSecond = true;

  Future<void> getSomeSecond() async {
    emit(LoadingSecond());
    await Future.delayed(Duration(milliseconds: 1100));
    isLoading = true;
    isDoneSecond = false;
    emit(SuccessSecond());
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const DepartScreen(),
    const NewsScreen(),
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
      print('///////////////////////////////////////////////////////');
      print(userData);
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
  var allData;
  MemberTestModel? memberTestModel;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  bool isDoneNasa = true;

  Future getNasa() async {
    emit(LoadingNasaData());
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
    isDoneNasa = false;
    emit(SuccessNasaData());
    // memberTestModel = MemberTestModel.fromJson(allData);
    print(allData[0]['name']);
  }

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

    // UserData? userData;
    //
    // void getUserData()  {
    //   emit(LoadingGetUserData());
    //
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(token)
    //       .get()
    //       .then((value) {
    //    // userData = UserData.fromJson(value.data()!);
    //     print(value.data());
    //    print(token);
    //    print('///////////////////////////////////////////////////////////////////');
    //     print(userData!.email);
    //     emit(SuccessGetUserData());
    //   }).onError((error, stackTrace) {
    //     print(error);
    //     emit(ErrorGetUserData(error: error.toString()));
    //   });
    // }
    //
    //
    // Future<void> logout(context) async {
    //   await FirebaseAuth.instance.signOut().then((value) {
    //     CacheHelper.removeData(key: 'token').then((value) {
    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const LoginScreen(),
    //         ),
    //             (route) => false,
    //       );
    //       token='';
    //     });
    //
    //     emit(SuccessLogoutData());
    //   }).catchError((error) {
    //     emit(ErrorLogoutData());
    //   });
    // }
    //

    // LoginModel ?UserDatas;
    // void getProfileData() {
    //   emit(LoadingProfileData());
    //   DioHelper.getData(
    //     url: 'profile',
    //     token: token,
    //   ).then((value) {
    //     UserDatas = LoginModel.fromJson(value.data);
    //     print(UserDatas!.data!.name);
    //     emit(SuccessProfileData());
    //   }).catchError((error) {
    //     print(error.toString());
    //     emit(ErrorProfileData());
    //   });
    // }

    // void getUpdateData({
    //   required String name,
    //   required String email,
    //   required String phone,
    //   String? password,
    // }) {
    //   emit(LoadingUpdateData());
    //   DioHelper.putData(
    //     url: 'update-profile',
    //     token: token,
    //     data: {
    //       'name': name,
    //       'email': email,
    //       'phone': phone,
    //       'password': password,
    //     },
    //   ).then((value) {
    //     UserDatas = LoginModel.fromJson(value.data);
    //     print(UserDatas!.data!.name);
    //     Fluttertoast.showToast(
    //         msg: "Update Successfully ✔",
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.green,
    //         textColor: Colors.white,
    //         fontSize: 16.0
    //     );
    //
    //     emit(SuccessUpdateData(UserDatas!));
    //   }).catchError((error) {
    //     print(error.toString());
    //     emit(ErrorUpdateData());
    //   });
    // }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileData() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(ProfilePikerSuccessState());
      uploadProfile();
    } else {
      print('no Image ????');
      emit(ProfilePikerErrorState());
    }
  }

  String imageProfileUrl = '';

  void uploadProfile() {
    emit(LoadingUploadProfileUrl());

    storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        imageProfileUrl = value;
        print(imageProfileUrl);
        emit(SuccessUploadProfileUrl());
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
  List<int> postsLikes = [];
  List<int> postsCommentCount = [];
  List<CommentModel> postsComment = [];

  void getPosts() {
    emit(LoadingGetPosts());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
        });
        element.reference.collection('comments').get().then((value) {
          value.docs.forEach((element) {
            postsCommentCount.add(value.docs.length);
            postsComment.add(CommentModel.fromJson(element.data()));
          });
        });
      });
      isDonePosts = false;
      emit(SuccessGetPosts());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorGetPosts());
    });
  }


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
          FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get()
              .then((value) {
            value.reference.update({
              'like': false,
            });
          });

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

          FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get()
              .then((value) {
            value.reference.update({
              'like': true,
            });
          });
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
      time: DateFormat(
          'MMM d, hh:mm aaa'
      ).format(DateTime.now()),
      uId: userData!.uId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments').add(commentModel!.toJson())
        .then((value) {
      isComment = false;
      emit(SuccessCommentPosts());
    }).onError((error, stackTrace) {
      print(error);
      isComment = false;
      emit(ErrorCommentPosts());
    });
  }
}
