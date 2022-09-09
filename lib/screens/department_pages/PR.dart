import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/component.dart';
import '../../style/iCONS.dart';
import '../pop_card/custom_rect_tween.dart';
import '../pop_card/hero_dialog_route.dart';
import 'about_screen.dart';

class PR_screen extends StatefulWidget {
  const PR_screen({Key? key}) : super(key: key);

  @override
  State<PR_screen> createState() => _PR_screenState();
}

class _PR_screenState extends State<PR_screen> {
  Image? image1;
  Image? image2;

  @override
  void initState() {
    super.initState();
    image1 = Image.network(
        "https://img.freepik.com/free-vector/space-galaxy-background_53876-93034.jpg?w=996&t=st=1662675779~exp=1662676379~hmac=a020a0337208b91f67be49bf37a3821b459b6b8c6075deb2a2d5e93f4216420a");
    image2 = Image.network(
        'https://img.freepik.com/free-photo/rustic-black-wooden-background-with-copy-space_24972-1746.jpg?w=996&t=st=1662656469~exp=1662657069~hmac=676c78dc1e654f9e2f9c0ababeffa0bf17e3b741a46ca5b5af1c2782f1b46728');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1!.image, context);
    precacheImage(image2!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {},
      builder: (context, state) {
        var appbar = AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text('Public Relations',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
        );
        var cubit = NasaCubit.get(context);
        if (cubit.isDoneUser ||
            // cubit.isDoneNasa ||
            cubit.isDoneSecond) {
          return Scaffold(
            appBar: appbar,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Public Relations',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
            leading: Padding(
              padding: EdgeInsets.only(
                left: 0.w,
              ),
              child: IconButton(
                icon:
                    const Icon(IconBroken.Arrow___Left_2, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            actions: [
              Container(
                width: 33.w,
                child: IconButton(
                  icon: const Icon(IconBroken.Search, color: Colors.white),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 5.w,
                ),
                child: IconButton(
                  icon: const Icon(IconBroken.Info_Circle, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoScreen(
                                  imageTitle:
                                      'https://img.freepik.com/free-photo/diverse-young-people-talking-having-fun-together-cafe_1163-5145.jpg?w=996&t=st=1662391735~exp=1662392335~hmac=6c703e715634dd1cdad2e1670b38da38058721246fed35bd77135c85c508635d',
                                  title: 'Public Relations',
                                  text:
                                      'العلاقات عامة (PR) هي توجيه الرأي العام نحو منتجك من خلال مشاريع إلكترونية أو غير إلكترونية، أو عرض منتج ما لجمهور معيّن وخلق هالة إيجابية حوله، ويمكن أن نعرّف العلاقات العامة بأنها الجهاز الذي يربط المؤسسة بجمهورها الداخلي والخارجي. وقد ازدادت فاعلية هذا الجهاز كنتيجة للتقدم التكنولوجي وظهور وسائل الإعلام الرقابية والاجتماعية والتغيير المستمر للعالم، وقد زاد الطلب عليه وتعظمت حاجة الجمهور له، على الرغم من عدم وجود ما يكفي من شركات العلاقات العامة التي تلبّي حاجة الجمهور، حيث تقوم العلاقات العامة بنقل صورة للأنشطة والخدمات التي تقدمها الشركة أو المؤسسة للجمهور وتلبي حاجة الجمهور للحصول على تلك المعلومات.',
                                  imageText:
                                      'https://img.freepik.com/free-photo/graphic-designers-meeting_1170-2002.jpg?w=996&t=st=1662393452~exp=1662394052~hmac=cb0ae77b2ffb50f75f6874cd67cd36ff3086ab374df8b9cc9881350dea2606a7',
                                )));
                  },
                ),
              ),
            ],
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _buildItem(index),
            separatorBuilder: (context, index) => SizedBox(
              height: 0.h,
            ),
            itemCount: 1,
          ),
        );
      },
    );
  }

  Widget _buildItem(index) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.h),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => showDialogCard(),
            ),
          );
        },
        child: Hero(
          tag: 'hero',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 58.h,
                    ),
                    Container(
                      height: 165.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        image: DecorationImage(
                          image: image1!.image,
                          fit: BoxFit.cover,
                        ),
                        // gradient: LinearGradient(
                        //     colors: [
                        //       Color(0xFF0050AC),
                        //       Color(0xFF9354B9)
                        //     ],
                        //     begin: Alignment.bottomLeft,
                        //     end: Alignment.topRight,
                        //     stops: [0.4, 0.6])
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 22.w,
                              top: 88.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Omar Wahid',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.1.h,
                                    decoration: TextDecoration.none,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  'Static & Dynamic',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                      height: 1.h),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (true)
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 15.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('🥇',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              height: 0.9.h,
                                              decoration: TextDecoration.none,
                                              fontSize: 32.sp)),
                                      // Text('⚜',
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w500,
                                      //         color: Colors.white,
                                      //         height: 0.9.h,
                                      //         fontSize: 30.sp)),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                  top: (true) ? 19.5.h : 62.h,
                                ),
                                child: Icon(
                                  IconBroken.Document,
                                  color: Colors.white,
                                  size: 45.w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 18.w,
                  top: 0.h,
                  child: Container(
                    height: 149.h,
                    width: 149.w,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            // Color(0xFF9B2282),
                            // Color(0xFFEEA863),
                            Color(0xFF0050AC),
                            Colors.red.shade400
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: CircleAvatar(
                      radius: 74.r,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://firebasestorage.googleapis.com/v0/b/nasa-team.appspot.com/o/users%2Fimage_picker2195260294804211001.jpg?alt=media&token=2a9be40f-d230-463a-893e-4448fcaa459d',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showDialogCard() => Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: 'hero',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 2,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.r)),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.r),
                                image: DecorationImage(
                                  image: image2!.image,
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2.w,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 60.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('عمر وحيد',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                height: 1.3.h,
                                                color: Colors.white,
                                                fontSize: 18.sp)),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          IconBroken.Profile,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('الفرقة الرابعة',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                height: 1.3.h,
                                                fontSize: 18.sp)),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          IconBroken.Discount,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('احصاء وحاسب',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                height: 1.3.h,
                                                fontSize: 18.sp)),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          IconBroken.Work,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('ميمبر',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                height: 1.3.h,
                                                fontSize: 18.sp)),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          IconBroken.Info_Circle,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('1x🥇',
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                height: 1.3.h,
                                                fontSize: 18.sp)),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          IconBroken.Game,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RichText(
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(
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
                                              text: 'فيسبوك',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  height: 1.3.h,
                                                  fontFamily: 'Jannah',
                                                  fontSize: 22.sp)),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Icon(
                                          Icons.facebook_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 96.h,
                      child: GestureDetector(
                        onTap: () {
                          DisplayPlayPhoto(
                              context: context,
                              url:
                                  'https://firebasestorage.googleapis.com/v0/b/nasa-team.appspot.com/o/users%2Fimage_picker2195260294804211001.jpg?alt=media&token=2a9be40f-d230-463a-893e-4448fcaa459d');
                        },
                        child: Container(
                          height: 153.h,
                          width: 153.w,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF9B2282), Color(0xFFEEA863)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          child: CircleAvatar(
                            radius: 77.r,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/nasa-team.appspot.com/o/users%2Fimage_picker2195260294804211001.jpg?alt=media&token=2a9be40f-d230-463a-893e-4448fcaa459d'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
