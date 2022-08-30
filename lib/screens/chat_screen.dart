import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../all_cubit/shop_cubit/cubit_shop.dart';
import '../style/iCONS.dart';

var messageChatController = TextEditingController();
String yourComment = '';
var scrollController = ScrollController();

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // if (state is SuccessCommentPosts) {
        //   messageChatController.clear();
        //   yourComment = '';
        // }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            messageChatController.clear();
            yourComment = '';
            return true;
          },
          child: Scaffold(
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
              title: const Text('Group Chat',
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
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 21.w,
                  ),
                  child: IconButton(
                    icon: const Icon(IconBroken.Search, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 15.h,
                    ),
                    child: Column(
                      children: [
                        buildItemMessage(context),
                        SizedBox(
                          height: 1.h,
                        ),
                        buildItemMyMessage(context),
                        buildItemMessage(context),
                        SizedBox(
                          height: 1.h,
                        ),
                        buildItemMyMessage(context),
                        buildItemMessage(context),
                        SizedBox(
                          height: 1.h,
                        ),
                        buildItemMyMessage(context),
                        buildItemMessage(context),
                        SizedBox(
                          height: 1.h,
                        ),
                        buildItemMyMessage(context),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 6.h,
                    bottom: 7.h,
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
                                      scrollController.position.minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  // NasaCubit.get(context).commentPost(
                                  //     text: yourComment,
                                  //     postId:
                                  //     NasaCubit.get(context).postIdTest);
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  yourComment = value;
                                });
                              },
                              cursorColor: Colors.deepPurple[700],
                              controller: messageChatController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Message ...'),
                            ),
                          ),
                        ),
                        // NasaCubit.get(context).isComment
                        false
                            ? Padding(
                                padding: EdgeInsets.only(
                                  right: 10.w,
                                ),
                                child: CupertinoActivityIndicator(
                                  color: Colors.deepPurple,
                                  radius: 12.w,
                                ),
                              )
                            : Container(
                                height: 49.h,
                                color: Colors.deepPurple[700],
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      // NasaCubit.get(context).commentPost(
                                      //     text: yourComment,
                                      //     postId: NasaCubit.get(context)
                                      //         .postIdTest);
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItemMessage(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 5.h,
          ),
          child: CircleAvatar(
            radius: 23.r,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.network(
                'https://img.freepik.com/free-photo/relaxed-friendly-good-looking-european-guy-with-bristle-smiling-joyfully-with-white-healthy-teeth-holding-hands-pockets-being-happy-satisfied-posing-cheerfully-white-wall_176420-35904.jpg?w=996&t=st=1661890245~exp=1661890845~hmac=5e3df75d32292fc357c1d38b29ef1ff025eb1f917daed1392afe6f320128529a',
                fit: BoxFit.cover,
                height: 48.h,
                width: 48.w,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('Omar Wahid',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    // SizedBox(
                    //   width: 3.w,
                    // ),
                    // Icon(
                    //   Icons.check_circle,
                    //   color: Colors.blue,
                    //   size: 16.w,
                    // ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      DateFormat('h:mm a').format(DateTime.now()).toString(),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 9.5.sp,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 13.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(15.r),
                        bottomStart: Radius.circular(25.r),
                        bottomEnd: Radius.circular(15.r),
                      )),
                  // child: Text('${message.text}'),
                  child: Text('Hallo Man !!', style: TextStyle(height: 1.1.h)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItemMyMessage(context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('h:mm a').format(DateTime.now()).toString(),
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontSize: 9.5.sp),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text('You',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 13.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.5),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(15.r),
                  bottomStart: Radius.circular(15.r),
                  bottomEnd: Radius.circular(25.r),
                )),
            // child: Text('${message.text}'),
            child: Text('im not Man !!', style: TextStyle(height: 1.1.h)),
          ),
        ],
      ),
    );
  }
}
