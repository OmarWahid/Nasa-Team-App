import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class MEDIA_screen extends StatelessWidget {
  const MEDIA_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar =  AppBar(

          title: const Text('Social Media',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white)),
          leading: Padding(
            padding: EdgeInsets.only(
              left: 0.w,
            ),
            child: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          actions: [
            Container(
              width: 30.w,
              child: IconButton(
                icon: const Icon(IconBroken.Search, color: Colors.white),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 4.w,
              ),
              child: IconButton(
                icon: const Icon(IconBroken.Info_Circle, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoScreen(
                            imageTitle:
                            'https://img.freepik.com/free-photo/social-media-graphic_53876-144840.jpg?w=996&t=st=1662404323~exp=1662404923~hmac=562519b8c3cfc30f426c52ff64304eec1e45e552b35e6cf53d1f2978d38e3281',
                            title: 'Social Media',
                            text:
                            'وسائط أو وسائل التواصل الاجتماعي أو الإعلام الاجتماعي (بالإنجليزية: Social Media)‏ أحدث التطورات التي طرأت على الإنترنت والتي صاحبها ظهور العديد من تكنولوجيا ويب 2.0. بشكل عام يشير العديد من المختصين في علم الإنترنت بأن الإعلام الاجتماعي يمثل قفزة كبيرة للتواصل من خلال الشبكة العنكبوتية بشكل تفاعلي أكبر من السابق بكثير عندما كان التواصل محدوداً بمشاركة كميات قليلة جدا من المعلومات وسيطرة أكبر من مديري البيانات.'
                                'كما أتاح الإعلام الاجتماعي فرصًا عديدة منها قد تكون مكاناً للمتاجرة لبعض الشركات وبداية لكل المشاريع وقد يدعم بعضها المشاريع الصغيرة أيضا التشارك بالمعلومات بين جميع مشتركي الشبكة مع إمكانيات التفاعل المباشر والحر على المواقع الاجتماعية وعند نهاية كل مقال أو خبر',
                            imageText:
                            'https://img.freepik.com/free-photo/hand-drawn-illustrations-social-media_1134-78.jpg?w=996&t=st=1662404345~exp=1662404945~hmac=0b2051b18e3f614da4a6c703d800785af09f82341eea7ce72e597dd54696564d',
                          )));
                },
              ),
            ),
          ],
        );
        var cubit = NasaCubit.get(context);
        if (cubit.isDoneUser || cubit.isDoneNasa || cubit.isDoneSecond) {
          return Scaffold(
            appBar: appbar,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar:  AppBar(

            title: const Text('Social Media',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
            leading: Padding(
              padding: EdgeInsets.only(
                left: 0.w,
              ),
              child: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            actions: [
              Container(
                width: 30.w,
                child: IconButton(
                  icon: const Icon(IconBroken.Search, color: Colors.white),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 4.w,
                ),
                child: IconButton(
                  icon: const Icon(IconBroken.Info_Circle, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoScreen(
                              imageTitle:
                              'https://img.freepik.com/free-photo/social-media-graphic_53876-144840.jpg?w=996&t=st=1662404323~exp=1662404923~hmac=562519b8c3cfc30f426c52ff64304eec1e45e552b35e6cf53d1f2978d38e3281',
                              title: 'Social Media',
                              text:
                              'وسائط أو وسائل التواصل الاجتماعي أو الإعلام الاجتماعي (بالإنجليزية: Social Media)‏ أحدث التطورات التي طرأت على الإنترنت والتي صاحبها ظهور العديد من تكنولوجيا ويب 2.0. بشكل عام يشير العديد من المختصين في علم الإنترنت بأن الإعلام الاجتماعي يمثل قفزة كبيرة للتواصل من خلال الشبكة العنكبوتية بشكل تفاعلي أكبر من السابق بكثير عندما كان التواصل محدوداً بمشاركة كميات قليلة جدا من المعلومات وسيطرة أكبر من مديري البيانات.'
                                  'كما أتاح الإعلام الاجتماعي فرصًا عديدة منها قد تكون مكاناً للمتاجرة لبعض الشركات وبداية لكل المشاريع وقد يدعم بعضها المشاريع الصغيرة أيضا التشارك بالمعلومات بين جميع مشتركي الشبكة مع إمكانيات التفاعل المباشر والحر على المواقع الاجتماعية وعند نهاية كل مقال أو خبر',
                              imageText:
                              'https://img.freepik.com/free-photo/hand-drawn-illustrations-social-media_1134-78.jpg?w=996&t=st=1662404345~exp=1662404945~hmac=0b2051b18e3f614da4a6c703d800785af09f82341eea7ce72e597dd54696564d',
                            )));
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Text('Media'),
          ),
        );
      },
    );
  }
}
