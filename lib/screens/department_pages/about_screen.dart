import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/iCONS.dart';

var controllerSlid = ScrollController();

class InfoScreen extends StatefulWidget {
  final String imageTitle;
  final String title;
  final String text;
  final String imageText;

  const InfoScreen(
      {required this.imageTitle,
      required this.imageText,
      required this.text,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                pinned: true,
                //floating: true,
                stretch: true,
                expandedHeight: 180.h,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsetsDirectional.only(
                    start: innerBoxIsScrolled ? 55.w : 0.w,
                    bottom: innerBoxIsScrolled ? 3.h : 0.h,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                        ),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: innerBoxIsScrolled ? 17.sp : 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Jannah',
                              color: innerBoxIsScrolled
                                  ? Colors.white
                                  : Colors.white),
                        ),
                      ),
                    ],
                  ),
                  background: CachedNetworkImage(
                    imageUrl: widget.imageTitle,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding:
                 EdgeInsets.only(top: 12.h, bottom: 0, left: 14.w, right: 14.w),
            child: CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  // This is the flip side of the SliverOverlapAbsorber above.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    widget.text,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Jannah',

                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                        imageUrl: widget.imageText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                    ),
                    child: Text(
                      'وللمزيد من المعلومات يمكنكم زيارة هذه المواقع : ',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Jannah',

                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.facebook_rounded,
                          color: Colors.blue,
                          size: 40.w,
                        ),
                        Icon(
                          Icons.tiktok,
                          color: Colors.pink,
                          size: 40.w,
                        ),
                        Icon(
                          Icons.slow_motion_video_sharp,
                          color: Colors.red,
                          size: 40.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 14.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.whatsapp,
                          color: Colors.green,
                          size: 40.w,
                        ),
                        SizedBox(
                          width: 45.w,
                        ),
                        Icon(
                          Icons.message_outlined,
                          color: Colors.purpleAccent,
                          size: 38.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
