import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class HR_screen extends StatelessWidget {
  const HR_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar =   AppBar(

          title: const Text('Human Resources',
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
                            'https://img.freepik.com/free-photo/headhunters-interviewing-female-job-candidate_1163-4674.jpg?w=996&t=st=1662404105~exp=1662404705~hmac=a5435fc7680bed7bfeace4947712f67fc6c33f2d6612b105a5bd0288df4ba998',
                            title: 'Human Resources',
                            text:
                            'إدارة الموارد البشرية (بالإنجليزية: Human Resources Management)‏، هي إدارة القوى العاملة للمنظمات أو الموارد البشرية. وتختص بجذب الموظفين، والاختيار، التدريب، التقييم ومكافأة الموظفين، وأيضاً متابعة قيادة المنظمة والثقافة التنظيمية والتأكد من الامتثال بقوانين العمل. في حالات يكون الموظفون راغبين في إجراء مفاوضات جماعية، إدارة الموارد البشرية يكون دورها التواصل المبدئي مع ممثلي الموظفين (في العادة إتحادات العمال)'
                                'والموارد البشرية مجموع الأفراد المشكلين للقوى العاملة بمنظمة ما، أو قطاع أعمال أو اقتصاد ما. ويستخدم البعض مصطلح رأس المال البشري بشكل مترادف مع الموارد البشرية، على الرغم من رأس المال البشري عادة ما يشير إلى وجهة نظر أضيق،',
                            imageText:
                            'https://img.freepik.com/free-photo/african-american-people-greeting-job-interview-appointment-talking-about-hr-recruitment-work-application-man-woman-meeting-talk-about-executive-career-opportunity_482257-41875.jpg?w=1380&t=st=1662404187~exp=1662404787~hmac=e9bedd369d9bcf269ec707a400172e175e0bcae0e8b2b5ee9b9b9a9a06a8b47a',
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

            title: const Text('Human Resources',
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
                              'https://img.freepik.com/free-photo/headhunters-interviewing-female-job-candidate_1163-4674.jpg?w=996&t=st=1662404105~exp=1662404705~hmac=a5435fc7680bed7bfeace4947712f67fc6c33f2d6612b105a5bd0288df4ba998',
                              title: 'Human Resources',
                              text:
                              'إدارة الموارد البشرية (بالإنجليزية: Human Resources Management)‏، هي إدارة القوى العاملة للمنظمات أو الموارد البشرية. وتختص بجذب الموظفين، والاختيار، التدريب، التقييم ومكافأة الموظفين، وأيضاً متابعة قيادة المنظمة والثقافة التنظيمية والتأكد من الامتثال بقوانين العمل. في حالات يكون الموظفون راغبين في إجراء مفاوضات جماعية، إدارة الموارد البشرية يكون دورها التواصل المبدئي مع ممثلي الموظفين (في العادة إتحادات العمال)'
                                  'والموارد البشرية مجموع الأفراد المشكلين للقوى العاملة بمنظمة ما، أو قطاع أعمال أو اقتصاد ما. ويستخدم البعض مصطلح رأس المال البشري بشكل مترادف مع الموارد البشرية، على الرغم من رأس المال البشري عادة ما يشير إلى وجهة نظر أضيق،',
                              imageText:
                              'https://img.freepik.com/free-photo/african-american-people-greeting-job-interview-appointment-talking-about-hr-recruitment-work-application-man-woman-meeting-talk-about-executive-career-opportunity_482257-41875.jpg?w=1380&t=st=1662404187~exp=1662404787~hmac=e9bedd369d9bcf269ec707a400172e175e0bcae0e8b2b5ee9b9b9a9a06a8b47a',
                            )));
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Text('HR'),
          ),
        );
      },
    );
  }
}
