import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/screens/department_pages/HP.dart';
import 'package:nasa_app/screens/department_pages/MEDIA.dart';
import 'package:nasa_app/screens/department_pages/OR.dart';
import 'package:nasa_app/screens/department_pages/PR.dart';
import 'package:shimmer/shimmer.dart';
import '../all_cubit/shop_cubit/cubit_shop.dart';
import 'FadeAnimation.dart';
import 'department_pages/ART.dart';
import 'department_pages/HR.dart';
import 'department_pages/PROG.dart';

class DeepModel {
  String? image;
  String? title;
  String? description;
  Widget? widget;

  DeepModel({
    this.image,
    this.title,
    this.description,
    this.widget,
  });
}

List<DeepModel> list = [
  DeepModel(
    image: 'assets/images/Globalization-amico.png',
    title: 'High Board',
    description: 'HEADS',
    widget: HEADS_screen(),
  ),
  DeepModel(
    image: 'assets/images/Work anniversary-amico.png',
    title: 'Public Relations',
    description: 'PR',
    widget: PR_screen(),
  ),
  DeepModel(
    image: 'assets/images/Prototyping process-amico.png',
    title: 'Organizations',
    description: 'OR',
    widget: OR_screen(),
  ),
  DeepModel(
    image: 'assets/images/Social tree-cuate (2).png',
    title: 'Social Media',
    description: 'Media',
    widget: MEDIA_screen(),
  ),
  DeepModel(
    image: 'assets/images/Discussion-amico (1).png',
    title: 'Human Resources',
    description: 'HR',
    widget: HR_screen(),
  ),
  DeepModel(
    image: 'assets/images/Making art-cuate.png',
    title: 'Art & Design',
    description: 'ART',
    widget: ART_screen(),
  ),
  DeepModel(
    image: 'assets/images/Work time-amico.png',
    title: 'Programming',
    description: 'PROG',
    widget: PROG_screen(),
  ),
];

class DepartScreen extends StatelessWidget {
  final scrollController;

  const DepartScreen({required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NasaCubit.get(context);

        return Padding(
          padding: EdgeInsets.only(
            top: 12.h,
            right: 9.w,
            left: 9.w,
          ),
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) => (cubit.isDoneUser ||
                    cubit.isDoneNasa ||
                    cubit.isDoneSecond ||
                    cubit.isDonePosts)
                ? getItemShimmer()
                : FadeAnimation(
                    // (index == 6 || index == 5)
                    //     ? (index == 5)
                    //         ? (index - 1)
                    //         : (index - 4.9)
                    //     : (index - 0.269)
                    (index == 0)
                        ? 0.2
                        : (index == 1)
                            ? 0.6
                            : (index == 2)
                                ? 1
                                : (index == 3)
                                    ? 1.4
                                    : (index == 4)
                                        ? 1.8
                                        : (index == 5)
                                            ? 2.2
                                            : (index == 6)
                                                ? 0.3
                                                : 0.3,
                    _buildItem(list[index], context, index)),
            separatorBuilder: (context, index) => SizedBox(
              height: 13.h,
            ),
            itemCount: list.length,
          ),
        );
      },
    );
  }

  Widget _buildItem(DeepModel data, context, index) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: (index == 6) ? 13.h : 0.h,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              BouncyPage(widget: data.widget!, curve: Curves.fastOutSlowIn));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: Colors.deepPurple,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  top: 10.h,
                  bottom: 10.h,
                ),
                child: Container(
                  height: 109.h,
                  width: 116.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage('${data.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.title}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${data.description}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 11.w,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.w,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Shimmer getItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Container(
          height: 117.h,
          width: 116.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
