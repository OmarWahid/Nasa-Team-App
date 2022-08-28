import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import '../shared/component.dart';

class NasaLayout extends StatelessWidget {
  const NasaLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
        listener: (context, state) {
          if (state is SuccessLogoutData) {
            uId = '';

            NasaCubit.get(context).currentIndex = 0;
          }
        },
        builder: (context, state) {
          AppBar appBar = AppBar(
              centerTitle: true,
              elevation: 0,
              toolbarHeight: ScreenUtil().setHeight(48),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.r),
                    bottomRight: Radius.circular(45.r),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.deepPurple, Colors.deepPurple],
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: EdgeInsets.only(bottom: 9.h),
                child: Text('Nasa Team',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'old',
                      fontSize: ScreenUtil().setSp(30),
                      color: Colors.white,
                    )),
              ));
          height = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              appBar.preferredSize.height;
          width = MediaQuery.of(context).size.width;
          var cubit = NasaCubit.get(context);
          if (cubit.isDoneUser || cubit.isDoneNasa || cubit.isDoneSecond|| cubit.isDonePosts) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
              appBar: appBar,
            );
          }
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar:
                (cubit.status == ConnectivityResult.none) ? false : true,
            appBar: appBar,
            backgroundColor: Colors.white,
            body: Column(
              children: [
                if (cubit.status == ConnectivityResult.none)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                      right: 9.w,
                      left: 9.w,
                    ),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: Colors.red, //Color(0xFFEE4400),
                        borderRadius: BorderRadius.circular(45.r),
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "OFFLINE",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 12.0,
                              height: 12.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(child: cubit.screens[cubit.currentIndex]),
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 26.w,
                ),
                Icon(
                  Icons.newspaper_rounded,
                  color: Colors.white,
                  size: 25.w,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 26.w,
                ),
              ],
              index: cubit.currentIndex,
              color: Colors.deepPurple,
              buttonBackgroundColor: Colors.deepPurple.shade300,
              backgroundColor: Colors.transparent,
              animationDuration: Duration(milliseconds: 400),
              height: 43.h,
              animationCurve: Curves.easeInOut,
              onTap: (index) {
                cubit.changeScreen(index);
              },
            ),
          );
        },
      );
  }
}
