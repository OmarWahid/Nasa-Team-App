import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/posts_model.dart';

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
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
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
                          List<CommentModel> comments = [];

                          if (snapshot.hasData) {
                            for (var element in snapshot.data!.docs) {
                              comments.add(CommentModel.fromJson(
                                  element.data() as Map<String, dynamic>));
                            }
                            return Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildCommentItem(
                                      comments[index], index);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 13.h,
                                ),
                                itemCount: snapshot.data!.docs.length,
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
                    Container(
                      color: Colors.white,
                      height: 45.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                              ),
                              child: TextFormField(
                                controller: commentController,
                                cursorColor: Colors.black,
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty &&
                                      value != ' ' &&
                                      value != '  ' &&
                                      value != '   ' &&
                                      value != '    ') {
                                    NasaCubit.get(context).commentPost(
                                        text: yourComment,
                                        postId:
                                            NasaCubit.get(context).postIdTest);
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    yourComment = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Write a comment ...',
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
                              : IconButton(
                                  highlightColor: Colors.white,
                                  splashColor: Colors.white,
                                  icon: Icon(
                                    Icons.send_rounded,
                                    size: 24.w,
                                  ),
                                  onPressed: () {
                                    if (yourComment.isNotEmpty &&
                                        yourComment != ' ' &&
                                        yourComment != '  ' &&
                                        yourComment != '   ' &&
                                        yourComment != '    ') {
                                      NasaCubit.get(context).commentPost(
                                          text: yourComment,
                                          postId: NasaCubit.get(context)
                                              .postIdTest);
                                    }
                                  }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCommentItem(data, index) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0 ? 15.h : 0.h,
      ),
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
                child: CircleAvatar(
                  radius: 25.w,
                  backgroundColor: Colors.grey.shade100,
                  child: ClipOval(
                    child: Image.network(
                      data.image,
                      height: 44.h,
                      width: 50.w,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
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
                          textDirection: (data.text.contains(RegExp(r'[أ-ي]')))
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
    );
  }
}