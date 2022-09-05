import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class PROG_screen extends StatelessWidget {
  const PROG_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar =  AppBar(

          title: const Text('Programming',
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
                            'https://img.freepik.com/free-photo/professional-programmer-working-late-dark-office_1098-18705.jpg?w=996&t=st=1662404761~exp=1662405361~hmac=59baa91b46694632f298ed74e92fffbf22498ad99f9f6475fa50f67664f13714',
                            title: 'Programming',
                            text:
                            'لغة البرمجة (بالإنجليزية: Programming language)‏، هي مجموعة من الأوامر، تكتب وفق قواعد تُحَدَّد بواسطة لغة البرمجة، ومن ثُمَّ تمر هذه الأوامر بعدة مراحل إلى أن تنفذ على جهاز الحاسوب.'
                                'من الممكن تعريف البرمجة بأنها عملية كتابة تعليمات وأوامر لجهاز الحاسوب أو أي جهاز آخر، لتوجيهه وإعلامه بكيفية التعامل مع البيانات أو كيفية تنفيذ سلسلة من الأعمال المطلوبة.'
                                'تتبع عملية البرمجة قواعد خاصة باللغة التي اختارها المبرمج.'
                                'كل لغة لها خصائصها التي تميزها عن الأخرى وتجعلها مناسبة بدرجات متفاوتة لكل نوع من أنواع البرامج والمهمة المطلوبة من هذا البرنامج.'
                                'كما أن للغات البرمجة أيضاً خصائص مشتركة وحدود مشتركة بحكم أن كل هذه اللغات صممت للتعامل مع الحاسوب.'
                                'وتتطور لغات البرمجة (البرمجيات Software) بتطور الحاسوب (عتاد الحاسوب Hardware). فعندما ابتكر الحاسوب الإلكتروني في الأربعينيات والخمسينيات من القرن الماضي (بعد أجهزة الحساب الكهربائية في العشرينات)- وكان الكمبيوتر يعمل بأعداد كبيرة من الصمامات الإلكترونية - كانت لغة البرمجة معقدة هي الأخرى، وكانت عبارة عن سلسلة من الأعداد وتكتب على شكل أكواد برمجية طويلة هذه الاعداد هي الرقمين الصفر 0 والواحد 1 وهذه اللغة تدعى اللغة الثنائية أو لغة الآلة، وكان ذلك صعبا على المبرمجين. ولكن بابتكار الترانزيستور صغر حجم الحاسوب كثيرا وزادت إمكانياته، واستطاع المختصون والمبرمجون في نفس الوقت أن يبتكروا لغات برمجة أسهل للاستخدام، وأصبحت لغات البرمجة مفهومة إلى حد بعيد للمختصين. ولا يزال التطوير والتسهيل قائماً.',
                            imageText:
                            'https://img.freepik.com/free-photo/it-engineer-analyzing-code_1098-21513.jpg?w=996&t=st=1662404790~exp=1662405390~hmac=2ac04d9faec6f09f1c695ae9ebf15aff6b9e3176bbe3c6ae7e0cf03973223c96',
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

            title: const Text('Programming',
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
                              'https://img.freepik.com/free-photo/professional-programmer-working-late-dark-office_1098-18705.jpg?w=996&t=st=1662404761~exp=1662405361~hmac=59baa91b46694632f298ed74e92fffbf22498ad99f9f6475fa50f67664f13714',
                              title: 'Programming',
                              text:
                              'لغة البرمجة (بالإنجليزية: Programming language)‏، هي مجموعة من الأوامر، تكتب وفق قواعد تُحَدَّد بواسطة لغة البرمجة، ومن ثُمَّ تمر هذه الأوامر بعدة مراحل إلى أن تنفذ على جهاز الحاسوب.'
                                  'من الممكن تعريف البرمجة بأنها عملية كتابة تعليمات وأوامر لجهاز الحاسوب أو أي جهاز آخر، لتوجيهه وإعلامه بكيفية التعامل مع البيانات أو كيفية تنفيذ سلسلة من الأعمال المطلوبة.'
                                  'تتبع عملية البرمجة قواعد خاصة باللغة التي اختارها المبرمج.'
                                  'كل لغة لها خصائصها التي تميزها عن الأخرى وتجعلها مناسبة بدرجات متفاوتة لكل نوع من أنواع البرامج والمهمة المطلوبة من هذا البرنامج.'
                                  'كما أن للغات البرمجة أيضاً خصائص مشتركة وحدود مشتركة بحكم أن كل هذه اللغات صممت للتعامل مع الحاسوب.'
                                  'وتتطور لغات البرمجة (البرمجيات Software) بتطور الحاسوب (عتاد الحاسوب Hardware). فعندما ابتكر الحاسوب الإلكتروني في الأربعينيات والخمسينيات من القرن الماضي (بعد أجهزة الحساب الكهربائية في العشرينات)- وكان الكمبيوتر يعمل بأعداد كبيرة من الصمامات الإلكترونية - كانت لغة البرمجة معقدة هي الأخرى، وكانت عبارة عن سلسلة من الأعداد وتكتب على شكل أكواد برمجية طويلة هذه الاعداد هي الرقمين الصفر 0 والواحد 1 وهذه اللغة تدعى اللغة الثنائية أو لغة الآلة، وكان ذلك صعبا على المبرمجين. ولكن بابتكار الترانزيستور صغر حجم الحاسوب كثيرا وزادت إمكانياته، واستطاع المختصون والمبرمجون في نفس الوقت أن يبتكروا لغات برمجة أسهل للاستخدام، وأصبحت لغات البرمجة مفهومة إلى حد بعيد للمختصين. ولا يزال التطوير والتسهيل قائماً.',
                              imageText:
                              'https://img.freepik.com/free-photo/it-engineer-analyzing-code_1098-21513.jpg?w=996&t=st=1662404790~exp=1662405390~hmac=2ac04d9faec6f09f1c695ae9ebf15aff6b9e3176bbe3c6ae7e0cf03973223c96',
                            )));
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Text('Programming'),
          ),
        );
      },
    );
  }
}
