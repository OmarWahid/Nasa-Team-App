import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/screens/login/update_profile.dart';
import 'package:nasa_app/style/capital_letter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/shared/component.dart';

import '../style/iCONS.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        if (state is SuccessLogoutData) {
          uId = '';
          nasa = null;
        }
      },
      builder: (context, state) {
        var cubit = NasaCubit.get(context);
        if (cubit.isDoneUser ||
            cubit.isDoneNasa ||
            cubit.isDoneSecond ||
            cubit.isDonePosts) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final assetsAudioPlayer = AssetsAudioPlayer();

        nasa = NasaCubit.get(context).userData;
        return ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 71.r,
                          backgroundColor: Colors.deepPurple,
                          child: CircleAvatar(
                            radius: 68.r,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.network(
                                NasaCubit.get(context).userData!.image!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return loadingProgress == null
                                      ? child
                                      : Center(
                                          child: CupertinoActivityIndicator(
                                          color: Colors.deepPurple,
                                          radius: 13.r,
                                        ));
                                },
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                            radius: 17.r,
                            backgroundColor: Colors.deepPurple,
                            child: FittedBox(
                              child: IconButton(
                                  onPressed: () async {
                                    String refresh = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateScreen_()));
                                    if (refresh == 'refresh') {
                                      NasaCubit.get(context).getUserData();
                                    }

                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      NasaCubit.get(context).userData!.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 0.9.h,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(NasaCubit.get(context).userData!.bio!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.4.h,
                          fontSize: 13.sp,
                          color: Colors.grey,
                        )),
                    SizedBox(height: height * 0.034),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.078,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //color: Color(0xFFf7f2fc),
                            color: Colors.deepPurple.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              String refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateScreen_()));
                              if (refresh == 'refresh') {
                                NasaCubit.get(context).getUserData();
                              }
                            },
                            elevation: 0,
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Profile,
                                  color: Colors.deepPurple,
                                  size: 27.w,
                                ),
                                SizedBox(width: 17.w),
                                Expanded(
                                  child: Text(
                                    'My Account',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(IconBroken.Arrow___Right_Circle,
                                    size: 26.w, color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.026),
                        Container(
                          height: height * 0.078,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsPadding:
                                          EdgeInsetsDirectional.only(
                                        bottom: 10.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      title: Text('Invite Friends !!',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      content: Text(
                                          'You don\'t have friends at all, Why press invite a friend ?!',
                                          style: TextStyle(
                                            height: 1.3.h,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r),
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      assetsAudioPlayer.open(
                                                        Audio(
                                                            "assets/Lonely.wav"),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Lonely 🥰',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r),
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      assetsAudioPlayer.pause();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Okey 🙂',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            elevation: 0,
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Add_User,
                                  color: Colors.deepPurple,
                                  size: 27.w,
                                ),
                                SizedBox(width: 17.w),
                                Expanded(
                                  child: Text(
                                    'Invite a Friend',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(IconBroken.Arrow___Right_Circle,
                                    size: 26.w, color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.026),
                        Container(
                          height: height * 0.078,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsPadding:
                                          EdgeInsetsDirectional.only(
                                        bottom: 10.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      title: Text('Help & Support',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      content: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'to contact us, please send us a message on ',
                                              style: TextStyle(
                                                height: 1.3.h,
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final Uri url = Uri.parse(
                                                      'https://www.facebook.com/NasaTeam1/');
                                                  if (!await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalNonBrowserApplication)) {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                              text: 'facebook',
                                              style: TextStyle(
                                                color: Colors.deepPurple,
                                                height: 1.3.h,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Center(
                                          child: Container(
                                            width: 100.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            elevation: 0,
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Send,
                                  color: Colors.deepPurple,
                                  size: 26.w,
                                ),
                                SizedBox(width: 17.w),
                                Expanded(
                                  child: Text(
                                    'Help & Support',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(IconBroken.Arrow___Right_Circle,
                                    size: 26.w, color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.026),
                        Container(
                          height: height * 0.078,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actionsPadding:
                                          EdgeInsetsDirectional.only(
                                        bottom: 10.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      title: Text('NASA',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      // content: Column(
                                      //   mainAxisSize: MainAxisSize.min,
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //         'جميع الحقوق محفوظة لصالح Omar-Wahid©',
                                      //         textDirection: TextDirection.rtl,
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //             // fontWeight: FontWeight.bold,
                                      //
                                      //             )),
                                      //     Text('NASA | ناسا \n2022©',
                                      //         textDirection: TextDirection.rtl,
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //         )),
                                      //   ],
                                      // ),
                                      content: RichText(
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'جميع الحقوق محفوظة لصالح ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22.sp,
                                                  // height: 1.2.h,
                                                  fontFamily: 'Jannah',
                                                )),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final Uri url = Uri.parse(
                                                      'https://www.facebook.com/profile.php?id=100005007254697');
                                                  if (!await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalNonBrowserApplication)) {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                              text: 'Omar-Wahid©\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22.sp,
                                                height: 1.3.h,
                                                fontFamily: 'Jannah',
                                              ),
                                            ),
                                            TextSpan(
                                                text: 'NASA | ناسا \n2022©',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.2.w,
                                                  color: Colors.black,
                                                  fontSize: 23.sp,
                                                  height: 1.3.h,
                                                  fontFamily: 'Jannah',
                                                )),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Center(
                                          child: Container(
                                            width: 100.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            elevation: 0,
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Info_Circle,
                                  color: Colors.deepPurple,
                                  size: 26.w,
                                ),
                                SizedBox(width: 17.w),
                                Expanded(
                                  child: Text(
                                    'About',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(IconBroken.Arrow___Right_Circle,
                                    size: 26.w, color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.026),
                        Container(
                          height: height * 0.078,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      actionsPadding:
                                          EdgeInsetsDirectional.only(
                                        bottom: 10.h,
                                      ),
                                      title: Text('Logout',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      content: Text(
                                          'Are you sure you want to Logout ?',
                                          style: TextStyle(
                                            height: 1.3.h,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        Container(
                                          width: 100.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              NasaCubit.get(context)
                                                  .logout(context);
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
                                            borderRadius:
                                                BorderRadius.circular(5.r),
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
                            },
                            elevation: 0,
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Logout,
                                  color: Colors.deepPurple,
                                  size: 26.w,
                                ),
                                SizedBox(width: 17.w),
                                Expanded(
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(IconBroken.Arrow___Right_Circle,
                                    size: 26.w, color: Colors.deepPurple),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
