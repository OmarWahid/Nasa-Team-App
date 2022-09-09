import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class OR_screen extends StatelessWidget {
  const OR_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar = AppBar(

          title: const Text('Organizations',
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
                            'https://img.freepik.com/free-photo/people-working-business-project-together_23-2148746319.jpg?w=1060&t=st=1662404962~exp=1662405562~hmac=0fb35958dda1bd7c41722f00f94d11420be7bd35759a21acaa42494ce353d762',
                            title: 'Organizations',
                            text:
                            'المنظمة مجموعة من الأفراد لهم هدف معين، يستخدمون طريقا أو أكثر للوصول اليه. فمثلا هناك منظمات إنسانية، منظمات بيئية، منظمات عمالية، الخ....'
                                'المنظمة هي شخصية اعتبارية لها كيانها المستقل عن الأفراد المكونين لها .. وتدار بواسطة مجلس إدارة منتخب بواسطة الجمعية العامة للأعضاء.. وتنقسم المنظمات إلى نوعين حكومية وغير حكومية بالنظر إلى الأعضاء',
                            imageText:
                            'https://img.freepik.com/free-photo/crop-coworkers-using-modern-devices-desk_23-2147787547.jpg?size=626&ext=jpg&uid=R69862801',
                          )));
                },
              ),
            ),
          ],
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
          appBar:  AppBar(

            title: const Text('Organizations',
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
                              'https://img.freepik.com/free-photo/people-working-business-project-together_23-2148746319.jpg?w=1060&t=st=1662404962~exp=1662405562~hmac=0fb35958dda1bd7c41722f00f94d11420be7bd35759a21acaa42494ce353d762',
                              title: 'Organizations',
                              text:
                              'المنظمة مجموعة من الأفراد لهم هدف معين، يستخدمون طريقا أو أكثر للوصول اليه. فمثلا هناك منظمات إنسانية، منظمات بيئية، منظمات عمالية، الخ....'
                                  'المنظمة هي شخصية اعتبارية لها كيانها المستقل عن الأفراد المكونين لها .. وتدار بواسطة مجلس إدارة منتخب بواسطة الجمعية العامة للأعضاء.. وتنقسم المنظمات إلى نوعين حكومية وغير حكومية بالنظر إلى الأعضاء'
                                  'المنظمة مجموعة من الأفراد لهم هدف معين، يستخدمون طريقا أو أكثر للوصول اليه. فمثلا هناك منظمات إنسانية، منظمات بيئية، منظمات عمالية، الخ....'
                              'المنظمة هي شخصية اعتبارية لها كيانها المستقل عن الأفراد المكونين لها .. وتدار بواسطة مجلس إدارة منتخب بواسطة الجمعية العامة للأعضاء.. وتنقسم المنظمات إلى نوعين حكومية وغير حكومية بالنظر إلى الأعضاء',
                              imageText:
                              'https://img.freepik.com/free-photo/crop-coworkers-using-modern-devices-desk_23-2147787547.jpg?size=626&ext=jpg&uid=R69862801',
                            )));
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Text('OR'),
          ),
        );
      },
    );
  }
}
