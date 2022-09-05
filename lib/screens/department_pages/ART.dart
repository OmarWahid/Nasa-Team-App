import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class ART_screen extends StatelessWidget {
  const ART_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar =  AppBar(

          title: const Text('Art & Design',
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
                            'https://img.freepik.com/free-photo/copy-space-wooden-background-paint_23-2148660974.jpg?w=1380&t=st=1662403452~exp=1662404052~hmac=bb74bc6716d66ccb669631626d30e9f20f8d0e775299b332888ee8eedbab1614',
                            title: 'Art & Design',
                            text:
                            'الفن عبارة عن مجموعة متنوعة من الأنشطة البشرية في إنشاء أعمال بصرية أو سمعية أو أداء (حركية)، للتعبير عن أفكار المؤلف الإبداعية أو المفاهيمية أو المهارة الفنية، والمقصود أن يكون موضع تقدير لجمالها أو قوتها العاطفية. تشمل الأنشطة الأخرى المتعلقة بإنتاج الأعمال الفنية نقد الفن ودراسة تاريخ الفن والنشر الجمالي للفن.'
                                'الفروع الثلاثة الكلاسيكية للفن هي الرسم والنحت والعمارة. يتم تضمين الموسيقى والمسرح والسينما والرقص والفنون المسرحية الأخرى، وكذلك الأدب وغيرها من الوسائط مثل الوسائط التفاعلية، في تعريف أوسع للفنون. حتى القرن السابع عشر، كان الفن يشير إلى أي مهارة أو إتقان ولم يتم تمييزه عن الحرف أو العلوم. في الاستخدام الحديث بعد القرن السابع عشر، حيث الاعتبارات الجمالية أصبح لها أهمية قصوى، يتم فصل الفنون الجميلة وتمييزها عن المهارات المكتسبة بشكل عام، مثل الفنون الزخرفية أو التطبيقية.',
                            imageText:
                            'https://img.freepik.com/free-photo/medium-shot-woman-painting-canvas_23-2149050506.jpg?w=996&t=st=1662403502~exp=1662404102~hmac=0d6f13f3a927c84e84042b9fed843748280cbae048e7595897c9c20a933c093f',
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
          appBar: appbar,
          body: Center(
            child: Text('Art'),
          ),
        );
      },
    );
  }
}
