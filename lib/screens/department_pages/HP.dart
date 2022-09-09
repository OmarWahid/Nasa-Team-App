import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';
import 'about_screen.dart';

class HEADS_screen extends StatelessWidget {
  const HEADS_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar = AppBar(
          title: const Text('High Board',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
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
                                    'https://img.freepik.com/free-photo/management-coaching-business-dealing-mentor-concept_53876-133858.jpg?w=900&t=st=1662403906~exp=1662404506~hmac=65f3834380726eac6045ad6b58d2f8c32d0d41857b690185b2739ed95714ba44',
                                title: 'High Board',
                                text:
                                    'العلاقات عامة (PR) هي توجيه الرأي العام نحو منتجك من خلال مشاريع إلكترونية أو غير إلكترونية، أو عرض منتج ما لجمهور معيّن وخلق هالة إيجابية حوله، ويمكن أن نعرّف العلاقات العامة بأنها الجهاز الذي يربط المؤسسة بجمهورها الداخلي والخارجي. وقد ازدادت فاعلية هذا الجهاز كنتيجة للتقدم التكنولوجي وظهور وسائل الإعلام الرقابية والاجتماعية والتغيير المستمر للعالم، وقد زاد الطلب عليه وتعظمت حاجة الجمهور له، على الرغم من عدم وجود ما يكفي من شركات العلاقات العامة التي تلبّي حاجة الجمهور، حيث تقوم العلاقات العامة بنقل صورة للأنشطة والخدمات التي تقدمها الشركة أو المؤسسة للجمهور وتلبي حاجة الجمهور للحصول على تلك المعلومات.',
                                imageText:
                                    'https://img.freepik.com/free-photo/business-people-analyzing-statistics-financial-concept_53876-23509.jpg?w=900&t=st=1662403941~exp=1662404541~hmac=356204e378ac819e96ca8ef394661627c343e4fd68727e3362baa81d97907f1e',
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
          appBar: appbar,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Center(
            child: Text('HP'),
          ),
        );
      },
    );
  }
}
