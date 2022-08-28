import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/all_cubit/login_cubit/states.dart';
import 'package:nasa_app/layout/home_layout.dart';

import '../../all_cubit/login_cubit/cubit.dart';
import '../../all_cubit/shop_cubit/cubit_shop.dart';

var formKey = GlobalKey<FormState>();

var phoneController = TextEditingController();
var nameController = TextEditingController();
var passwordController = TextEditingController();
var emailController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
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
      listener: (context, state) async {
        if (state is CreateDataSuccessState) {
          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/lottie.json',
                        controller: _controller,
                        repeat: false,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration;
                          _controller.forward();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 17.h,
                        ),
                        child: Text(
                          '🔥 WELCOME 🔥\n🎉 TO NASA TEAM 🎉',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                );
              });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const NasaLayout(),
              ),
                  (route) => false);
          NasaCubit.get(context).getUserData();

          phoneController.clear();
          nameController.clear();
          passwordController.clear();
          emailController.clear();
        }
        if (state is ShopRegisterErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var width = MediaQuery
            .of(context)
            .size
            .width;
        var height = MediaQuery
            .of(context)
            .size
            .height -
            MediaQuery
                .of(context)
                .padding
                .top;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: EdgeInsets.only(top: 20.5.h, left: width * 0.055),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/10_FEB_10.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.055),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Register in Our Team Now 👾',
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.035,
                          ),
                          //name form field
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your name";
                              }
                              return null;
                            },
                            // style: TextStyle(color:Colors.white ),
                            decoration: InputDecoration(
                              label: Text("Name"),
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              // labelStyle: TextStyle(color: Colors.white),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: height * 0.026,
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your phone";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text("Phone"),
                              prefixIcon: Icon(Icons.phone),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: height * 0.026,
                          ),

                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text("Email Address"),
                              prefixIcon: Icon(Icons.email_outlined),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: height * 0.026,
                          ),
                          //password form field
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter a valid password";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).registerUser(
                                  name: (nameController.text.endsWith(' '))
                                      ? nameController.text.substring(
                                      0, nameController.text.lastIndexOf(' '))
                                      : nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              label: const Text("Password"),
                              prefixIcon: const Icon(Icons.lock_outline),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changeVisibilityPassReg();
                                },
                                icon: Icon(
                                  LoginCubit
                                      .get(context)
                                      .iconReg,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit
                                .get(context)
                                .isPassReg,
                          ),
                          SizedBox(
                            height: height * 0.037,
                          ),

                          (state is! ShopRegisterLoadingState)
                              ? Container(
                            width: double.infinity,
                            height: height * 0.075,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: MaterialButton(
                              onPressed: () {

                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).registerUser(
                                    name: (nameController.text.endsWith(' '))
                                        ? nameController.text.substring(
                                        0, nameController.text.lastIndexOf(' '))
                                        : nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                              : const Center(
                              child: CircularProgressIndicator()),
                          SizedBox(
                            height: height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
