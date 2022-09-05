import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class PR_screen extends StatelessWidget {
  const PR_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar = AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text('Public Relations',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
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
          appBar: AppBar(

            title: const Text('Public Relations',
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
          body: Center(
            child: Text('PR'),
          ),
        );
      },
    );
  }
}
