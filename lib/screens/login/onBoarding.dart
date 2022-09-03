import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../network/cache_helper.dart';
import 'login.dart';

var controllerBoard = PageController();
bool isLastPage = false;

class ModelingPage {
  late String title;
  late String description;
  late String image;
  ModelingPage(
      {required this.title, required this.description, required this.image});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    List<ModelingPage> listPages = [
      ModelingPage(
        title: 'Welcome to NASA Team',
        description: 'Do you want to join us?',
        image: 'assets/images/OnBoarding_3.png',
      ),
      ModelingPage(
        title: 'Our Goal is to Help Students',
        description:
            'We are here to help you to find the best way to learn and develop your skills',
        image: 'assets/images/nasa logo.png',
      ),
    ];
    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          print(value);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return buildItemPage(listPages[index]);
                },
                itemCount: listPages.length,
                physics: const NeverScrollableScrollPhysics(),
                controller: controllerBoard,
                onPageChanged: (index) {
                  if (index == listPages.length - 1) {
                    setState(() {
                      isLastPage = true;
                      print(isLastPage);
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                      print(isLastPage);
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                        controller: controllerBoard,
                        onDotClicked: (index) {
                          controllerBoard.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        count: listPages.length,
                        effect: ExpandingDotsEffect(
                          dotWidth: 10.w,
                          dotHeight: 12.h,
                          expansionFactor: 4.w,
                          spacing: 5.w,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.deepPurple,

                        ),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                          backgroundColor: Colors.deepPurpleAccent,
                          onPressed: () {
                            if (isLastPage) {
                              submit();
                            } else {
                              controllerBoard.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                          },
                          child: const Icon(Icons.arrow_forward)),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemPage(ModelingPage page) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: !isLastPage
              ? Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(0),
                    right: ScreenUtil().setWidth(20),
                  ),
                  child:
                      Image(image: AssetImage(page.image), fit: BoxFit.cover),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(55),
                    right: ScreenUtil().setWidth(55),
                  ),
                  child: Image(
                    image: AssetImage(page.image),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: TextStyle(
                  fontSize: 28.sp,
                  height: 1.03.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                page.description,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  height: 1.1.h,

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
