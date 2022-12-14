import 'package:achievement_view/achievement_view.dart';
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
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/model/chat_model.dart';
import 'package:nasa_app/screens/search_screen.dart';
import 'package:nasa_app/shared/component.dart';
import '../all_cubit/shop_cubit/cubit_shop.dart';
import '../model/login_model.dart';
import '../style/iCONS.dart';

List<ChatModel> chatList = [];
var messageChatController = TextEditingController();
String yourComment = '';
var scrollController = ScrollController();

class ChatScreen extends StatefulWidget {
  final SocialModel user;

  const ChatScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        if (state is SuccessGroupSendMessage) {
          messageChatController.clear();
          yourComment = '';
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            messageChatController.clear();
            yourComment = '';
            return true;
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              toolbarHeight: ScreenUtil().setHeight(42),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen(
                                    chatListSearch: chatList,
                                  )));
                    },
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chat')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    print(
                        '7777777777777777777 is Working 7777777777777777777777');
                    List<String> chatsId = [];
                    chatList = [];
                    if (snapshot.hasData) {
                      print('8888888888888888 is Working 8888888888888888888');

                      for (var element in snapshot.data!.docs) {
                        chatList.add(ChatModel.fromJson(
                            element.data() as Map<String, dynamic>));
                        chatsId.add(element.id);
                      }
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            reverse: true,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              if (chatList[index].senderId == widget.user.uId) {
                                return buildItemMyMessage(context,
                                    chatList[index], chatsId[index], index);
                              }
                              return buildItemMessage(
                                  context, chatList[index], index);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 5.h,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                      );
                    }
                  },
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
                                  NasaCubit.get(context).groupSendMessage(
                                    text: yourComment,
                                  );
                                }
                              },
                              textDirection:
                                  (yourComment.contains(RegExp(r'[??-??]')))
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
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
                        NasaCubit.get(context).isMessage
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
                                      NasaCubit.get(context).groupSendMessage(
                                        text: yourComment,
                                      );
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

  Widget buildItemMessage(context, ChatModel model, index) {
    String givenStr = model.time!;
    String finalStr = givenStr.substring(14, 19) + givenStr.substring(22);
    return Padding(
      padding: EdgeInsets.only(
        bottom: index == 0 ? 9.h : 0.h,
      ),
      child: FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.3,
        blurSize: 1,
        menuItemExtent: 45,
        menuBoxDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        duration: Duration(milliseconds: 0),
        animateMenuItems: false,
        blurBackgroundColor: Colors.white,
        openWithTap: false,
        menuOffset: 10.0,
        bottomOffsetHeight: 80.0,
        menuItems: [
          FocusedMenuItem(
              title: Text("Copy",
                style: TextStyle( color: Colors.white),),
              backgroundColor: Colors.deepPurpleAccent,
              trailingIcon: Icon(Icons.content_copy,color: Colors.white,),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: model.text));
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
                style: TextStyle(height: 1.2, color: Colors.white),
              ),
              backgroundColor: Colors.deepPurpleAccent,
              trailingIcon: Icon(
                Icons.report_gmailerrorred_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                showMessage(context);
              }),
        ],
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              child: InkWell(
                onTap: () {
                  DisplayPlayPhoto(url: model.image!, context: context);
                },
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: model.image!,
                      fit: BoxFit.cover,
                      height: 50.h,
                      width: 50.w,
                      placeholder: (context, url) {
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
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: (model.name! == 'Omar Wahid')
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(model.name!,
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                        if (model.name! == 'Omar Wahid')
                          SizedBox(
                            width: 3.w,
                          ),
                        if (model.name! == 'Omar Wahid')
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.1.w,
                          ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          finalStr,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 9.5.sp,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 9.h,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(15.r),
                            bottomStart: Radius.circular(25.r),
                            bottomEnd: Radius.circular(15.r),
                          )),
                      // child: Text('${message.text}'),
                      child: Text(model.text!,
                          textDirection:
                              (model.text!.contains(RegExp(r'[??-??]')))
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          style: TextStyle(height: 1.1.h)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemMyMessage(context, ChatModel model, chatsId, index) {
    String givenStr = model.time!;
    String finalStr = givenStr.substring(14, 19) + givenStr.substring(22);
    return Padding(
      padding: EdgeInsets.only(
        bottom: index == 0 ? 9.h : 0.h,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: FocusedMenuHolder(
          menuWidth: MediaQuery.of(context).size.width * 0.3,
          blurSize: 1,
          menuItemExtent: 45,
          menuBoxDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          duration: Duration(milliseconds: 0),
          animateMenuItems: false,
          blurBackgroundColor: Colors.white,
          openWithTap: false,
          menuOffset: 10.0,
          bottomOffsetHeight: 80.0,
          menuItems: [
            FocusedMenuItem(
                title: Text(
                  "Copy",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.deepPurpleAccent,
                trailingIcon: Icon(
                  Icons.content_copy,
                  color: Colors.white,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: model.text));
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
                backgroundColor: Colors.deepPurpleAccent,
                title: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white, height: 1.2),
                ),
                trailingIcon: Icon(
                  Icons.delete,
                  color: Colors.white,
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
                          title: Text('Delete Message',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              )),
                          content: Text(
                              'Are you sure you want to delete this message?',
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
                                      .deleteMessageChat(
                                    chatId: chatsId,
                                  );
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
          ],
          onPressed: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    finalStr,
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
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 9.h,
                ),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.4),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(15.r),
                      bottomStart: Radius.circular(15.r),
                      bottomEnd: Radius.circular(25.r),
                    )),
                // child: Text('${message.text}'),
                child: Text(model.text!,
                    textDirection: (model.text!.contains(RegExp(r'[??-??]')))
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style: TextStyle(height: 1.1.h)),
              ),
            ],
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
