import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

class EditCommentScreen extends StatelessWidget {
  final String postId;
  final String commentId;
  final String text;

  const EditCommentScreen(
      {required this.commentId,
      required this.postId,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    commentController.text = text;
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        if (state is SuccessEditCommentPosts) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: ScreenUtil().setHeight(48),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45.r),
                  bottomRight: Radius.circular(45.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.deepPurple],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            title: const Text('Edit Comment',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
            leading: Padding(
              padding: EdgeInsets.only(
                left: 21.w,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 13.w,
                  right: 13.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.w),
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
                            textDirection: (commentController.text
                                    .contains(RegExp(r'[أ-ي]')))
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            decoration: const InputDecoration(
                              hintText: 'Comment ...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      NasaCubit.get(context).isDoneEdit
                          ? Padding(
                              padding: EdgeInsets.only(
                                right: 15.w,
                              ),
                              child: CupertinoActivityIndicator(
                                color: Colors.deepPurple,
                                radius: 12.w,
                              ),
                            )
                          : Container(
                              height: 49.h,
                              color: Colors.deepPurple,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                  NasaCubit.get(context).editComment(
                                      postId: postId,
                                      commentId: commentId,
                                      text: commentController.text);
                                },
                                child: Text('Save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
