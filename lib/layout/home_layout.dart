import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidable/hidable.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/FadeAnimation.dart';
import '../screens/chat_screen.dart';
import '../shared/component.dart';
import '../style/iCONS.dart';

final scrollController = ScrollController();

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
        if (cubit.isDoneUser ||
            cubit.isDoneNasa ||
            cubit.isDoneSecond ||
            cubit.isDonePosts) {
          return Scaffold(
            appBar: appBar,
            body: Padding(
              padding: EdgeInsets.only(
                top: 6.h,
                bottom: 6.h,
                right: 6.w,
                left: 6.w,
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => getItemShimmer(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 0.h,
                ),
                itemCount: 7,
              ),
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r)),
                    actionsPadding: EdgeInsetsDirectional.only(
                      bottom: 10.h,
                    ),
                    title: Text('Are you sure?',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        )),
                    content: Text('Do you want to exit this app ?',
                        style: TextStyle(
                          height: 1.3.h,
                          fontWeight: FontWeight.bold,
                        )),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            return Navigator.of(context).pop(true);
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            return Navigator.of(context).pop(false);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          },
          child: Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    BouncyPage(
                        widget: ChatScreen(
                          user: cubit.userData!,
                        ),
                        curve: Curves.easeOutBack));
              },
              child: Icon(
                IconBroken.Chat,
                size: 29.w,
              ),
              backgroundColor: Colors.deepPurple,
            ),
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
            bottomNavigationBar: Hidable(
              controller: scrollController,

              child: CurvedNavigationBar(
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
            ),
          ),
        );
      },
    );
  }

  Shimmer getItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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

// import 'package:flutter/material.dart';
// import 'package:hidable/hidable.dart';
//
// class HidableBtmbarExample extends StatefulWidget {
//   const HidableBtmbarExample({Key? key}) : super(key: key);
//
//   @override
//   State<HidableBtmbarExample> createState() => _HidableBtmbarExampleState();
// }
//
// class _HidableBtmbarExampleState extends State<HidableBtmbarExample> {
//   int _index = 0;
//   final _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.separated(
//         controller: _scrollController, // !Explicitly specify the controller
//         itemBuilder: (_, i) => Container(
//           height: 80,
//           color: Colors.primaries[i % Colors.primaries.length],
//         ),
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemCount: 100,
//       ),
//       bottomNavigationBar: Hidable(
//         controller: _scrollController, // !Use the same controller
//         child: BottomNavigationBar(
//           currentIndex: _index,
//           onTap: (i) => setState(() => _index = i),
//           items: bottomBarItems(),
//         ),
//       ),
//     );
//   }
//
//   List<BottomNavigationBarItem> bottomBarItems() {
//     return [
//       BottomNavigationBarItem(
//         label: 'Home',
//         icon: const Icon(Icons.home, color: Colors.white),
//         backgroundColor: Colors.amber.withOpacity(.9),
//       ),
//       BottomNavigationBarItem(
//         label: 'Favorites',
//         icon: const Icon(Icons.favorite, color: Colors.white),
//         backgroundColor: Colors.blue.withOpacity(.9),
//       ),
//       BottomNavigationBarItem(
//         label: 'Profile',
//         icon: const Icon(Icons.person, color: Colors.white),
//         backgroundColor: Colors.green.withOpacity(.9),
//       ),
//       BottomNavigationBarItem(
//         label: 'Settings',
//         icon: const Icon(Icons.settings, color: Colors.white),
//         backgroundColor: Colors.purple.withOpacity(.9),
//       ),
//     ];
//   }
// }
