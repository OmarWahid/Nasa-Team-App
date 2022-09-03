import 'package:achievement_view/achievement_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/screens/edit_comment.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:achievement_view/achievement_view.dart';
import '../model/posts_model.dart';
import '../shared/component.dart';
import '../style/iCONS.dart';

var scrollController = ScrollController();
var commentController = TextEditingController();
var formKey = GlobalKey<FormState>();
String yourComment = '';

class CommentsScreen extends StatefulWidget {
  final int indexComments;

  const CommentsScreen({required this.indexComments, Key? key})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        if (state is SuccessCommentPosts) {
          commentController.clear();
          yourComment = '';
        }
      },
      builder: (context, state) {
        if (state is LoadingGetUserData || state is LoadingGetPosts) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 22.w,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      commentController.clear();
                      yourComment = '';
                    },
                  ),
                ),
              ],
              titleSpacing: 0,
              centerTitle: false,
              title: Transform(
                transform: Matrix4.translationValues(-30.w, 0.0, 0.0),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            commentController.clear();
            yourComment = '';
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 22.w,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      commentController.clear();
                      yourComment = '';
                    },
                  ),
                ),
              ],
              titleSpacing: 0,
              centerTitle: false,
              title: Transform(
                transform: Matrix4.translationValues(-30.w, 0.0, 0.0),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(NasaCubit.get(context).postIdTest)
                          .collection('comments')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        print(
                            '7777777777777777777 is Working 7777777777777777777777');
                        List<CommentModel> comments = [];
                        List<String> commentsId = [];

                        if (snapshot.hasData) {
                          print(
                              '8888888888888888888888 is Working 8888888888888888');

                          for (var element in snapshot.data!.docs) {
                            comments.add(CommentModel.fromJson(
                                element.data() as Map<String, dynamic>));
                            commentsId.add(element.id);
                          }
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: ListView.separated(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildCommentItem(comments[index],
                                      commentsId[index], index);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 13.h,
                                ),
                                itemCount: snapshot.data!.docs.length,
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 13.w,
                      right: 13.w,
                      bottom: 7.h,
                      top: 6.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.w),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            //message form field
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: TextFormField(
                                controller: commentController,
                                cursorColor: Colors.black,
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty &&
                                      value != ' ' &&
                                      value != '  ' &&
                                      value != '   ' &&
                                      value != '    ' &&
                                      value != '     ' &&
                                      value != '      ' &&
                                      value != '       ') {
                                    scrollController.animateTo(
                                        scrollController
                                            .position.minScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    NasaCubit.get(context).commentPost(
                                        text: yourComment,
                                        postId:
                                            NasaCubit.get(context).postIdTest);
                                  }
                                },
                              textDirection:(yourComment.contains(RegExp(r'[أ-ي]')))
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                onChanged: (value) {
                                  setState(() {
                                    yourComment = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Comment ...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          NasaCubit.get(context).isComment
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    right: 10.w,
                                  ),
                                  child: CupertinoActivityIndicator(
                                    color: Colors.black,
                                    radius: 12.w,
                                  ),
                                )
                              : Container(
                                  height: 49.h,
                                  color: Colors.black.withOpacity(0.9),
                                  child: MaterialButton(
                                    minWidth: 1.0,
                                    onPressed: () {
                                      if (yourComment.isNotEmpty &&
                                          yourComment != ' ' &&
                                          yourComment != '  ' &&
                                          yourComment != '   ' &&
                                          yourComment != '    ' &&
                                          yourComment != '     ' &&
                                          yourComment != '      ' &&
                                          yourComment != '       ') {
                                        scrollController.animateTo(
                                            scrollController
                                                .position.minScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                        NasaCubit.get(context).commentPost(
                                            text: yourComment,
                                            postId: NasaCubit.get(context)
                                                .postIdTest);
                                      }
                                    },
                                    child: Icon(
                                      IconBroken.Send,
                                      size: 22.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCommentItem(data, idComment, index) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0 ? 15.h : 0.h,
      ),
      child: FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        blurSize: 1.5,
        menuItemExtent: 45,
        menuBoxDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        duration: Duration(milliseconds: 0),
        animateMenuItems: false,
        blurBackgroundColor: Colors.black12,
        openWithTap: false,
        menuOffset: 10.0,
        bottomOffsetHeight: 80.0,
        menuItems: (NasaCubit.get(context).userData!.uId == data.uId)
            ? [
                FocusedMenuItem(
                    title: Text("Favorite"),
                    trailingIcon: Icon(Icons.favorite_border),
                    onPressed: () {}),
                FocusedMenuItem(
                    title: Text("Copy"),
                    trailingIcon: Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: data.text));
                      Fluttertoast.showToast(
                          msg: "Copied to clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 13.sp);
                    }),
                FocusedMenuItem(
                    title: Text("Edit"),
                    trailingIcon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditCommentScreen(
                                    postId: NasaCubit.get(context).postIdTest,
                                    commentId: idComment,
                                    text: data.text,
                                  )));
                    }),
                FocusedMenuItem(
                    title: Text(
                      "Delete",
                      style: TextStyle(color: Colors.redAccent, height: 1.2),
                    ),
                    trailingIcon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.r)),
                              actionsPadding: EdgeInsetsDirectional.only(
                                bottom: 10.h,
                              ),
                              title: Text('Delete Comment',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  )),
                              content: Text(
                                  'Are you sure you want to delete this comment?',
                                  style: TextStyle(
                                    height: 1.3.h,
                                    fontWeight: FontWeight.bold,
                                  )),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      await NasaCubit.get(context)
                                          .deleteComment(
                                              postId: NasaCubit.get(context)
                                                  .postIdTest,
                                              commentId: idComment);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
              ]
            : [
                FocusedMenuItem(
                    title: Text(
                      "Favorite",
                    ),
                    trailingIcon: Icon(Icons.favorite_border),
                    onPressed: () {}),
                FocusedMenuItem(
                    title: Text("Copy"),
                    trailingIcon: Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: data.text));
                      Fluttertoast.showToast(
                          msg: "Copied to clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 13.sp);
                    }),
                FocusedMenuItem(
                    title: Text(
                      "Report",
                      style: TextStyle(height: 1.2, color: Colors.redAccent),
                    ),
                    trailingIcon: Icon(
                      Icons.report_gmailerrorred_sharp,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      showMessage(context);
                    }),
              ],
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 7.h,
              bottom: 10.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 3.h,
                  ),
                  child: InkWell(
                    onTap: () {
                      DisplayPlayPhoto(url: data.image, context: context);
                    },
                    child: CircleAvatar(
                      radius: 25.w,
                      backgroundColor: Colors.grey.shade100,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: data.image,
                          height: 44.h,
                          width: 50.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return SizedBox(
                              height: 44.h,
                              width: 50.w,
                              child: const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.deepPurple,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 13.w,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(data.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  height: 1.3.h,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Jannah',
                                  color: Color(0xff000000),
                                )),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              '•',
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Jannah',
                                color: Color(0xff000000),
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                              child: Text(
                                timeago.format(DateTime.parse(data.time),
                                    locale: 'en'),
                                style: (MediaQuery.of(context).size.width <=
                                        410.6)
                                    ? (MediaQuery.of(context).size.width <= 375)
                                        ? TextStyle(
                                            fontSize: 8.54.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFA5ACB8),
                                          )
                                        : TextStyle(
                                            fontSize: 9.77.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFA5ACB8),
                                          )
                                    : TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA5ACB8),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        Text(data.text,
                            textDirection:
                                (data.text.contains(RegExp(r'[أ-ي]')))
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 11.h,
                              height: 1.1.h,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMessage(BuildContext context) {
    AchievementView(context,
        alignment: Alignment.center,
        title: "Thank You !!",
        subTitle: "We\'ve received your report and we will investigate",
        textStyleSubTitle: TextStyle(fontSize: 13.5.sp, height: 1.35),
        textStyleTitle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToLeft,
        icon: Icon(
          Icons.insert_emoticon,
          color: Colors.white,
          size: 30.w,
        ),
        color: Colors.deepPurpleAccent,
        isCircle: true, listener: (status) {
      print(status);
    })
      ..show();
  }
}
