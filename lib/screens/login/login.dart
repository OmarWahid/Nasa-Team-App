import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/screens/login/register.dart';
import 'package:nasa_app/shared/component.dart';

import '../../all_cubit/login_cubit/cubit.dart';
import '../../all_cubit/login_cubit/states.dart';
import '../../layout/home_layout.dart';
import '../../network/cache_helper.dart';
import '../FadeAnimation.dart';

var controllerEmail_ = TextEditingController();
var controllerPassword_ = TextEditingController();
var keyForm_ = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async{

        if (state is LoginSuccessState) {
        await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.r)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie.json',
                        controller: _controller,
                        repeat: false,
                        onLoaded: (composition) {
                          _controller.duration =
                              composition.duration;
                          _controller.forward();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 17.h,
                        ),
                        child: FittedBox(
                          child: Text(
                            '🔥 WELCOME 🔥\n🎉 TO NASA TEAM 🎉',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
          CacheHelper.saveData(key: 'uId', value: state.myId).then((value) {
            uId = state.myId;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const NasaLayout(),
                ),
                (route) => false);
            NasaCubit.get(context).getUserData();
            controllerEmail_.clear();
            controllerPassword_.clear();
          });
        }
        if (state is LoginErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0);
        }
      },
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: keyForm_,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 333.h,
                    width: width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: -34.h,
                          height: 357.h,
                          width: width,
                          child: FadeAnimation(
                              1,
                              Container(
                                width: double.infinity,
                                height: 325.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background.png'),
                                        fit: BoxFit.fill)),
                              )),
                        ),
                        Positioned(
                          height: 359.h,
                          width: width + 20,
                          left: -1.w,
                          child: FadeAnimation(
                              1.3,
                              Container(
                                width: double.infinity,
                                height: 325.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background-2.png'),
                                        fit: BoxFit.fill)),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            1.7,
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.sp),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        FadeAnimation(
                            2.2,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                      blurRadius: 20.r,
                                      offset: Offset(0.w, 10.h),
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]!))),
                                    child: TextFormField(
                                      controller: controllerEmail_,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Username",
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: TextFormField(
                                      controller: controllerPassword_,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                      obscureText:
                                          LoginCubit.get(context).isPass,
                                      onFieldSubmitted: (value) {
                                        if (keyForm_.currentState!.validate()) {
                                          LoginCubit.get(context).loginUser(
                                              email: '${controllerEmail_.text}',
                                              password:
                                                  '${controllerPassword_.text}');
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock_outline),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              LoginCubit.get(context)
                                                  .changeVisibilityPass();
                                            },
                                            icon: Icon(
                                                LoginCubit.get(context).icon),
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 25.h,
                        ),
                        FadeAnimation(
                            2.7,
                            (state is! LoginLoadingState)
                                ? InkWell(
                                    onTap: () {
                                      if (keyForm_.currentState!.validate()) {
                                        LoginCubit.get(context).loginUser(
                                            email: '${controllerEmail_.text}',
                                            password:
                                                '${controllerPassword_.text}');
                                      }
                                    },
                                    child: Container(
                                      height: 42.h,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        color: Color.fromRGBO(49, 39, 79, 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 12.h,
                        ),
                        FadeAnimation(
                            3.1,
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'don\'t have an account? ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              BouncyPage(
                                                  widget: RegisterScreen(),
                                                  curve: Curves.elasticInOut));
                                        },
                                      text: 'sign up',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
