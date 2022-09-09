import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/all_cubit/login_cubit/states.dart';
import 'package:nasa_app/layout/home_layout.dart';
import 'package:nasa_app/style/capital_letter.dart';

import '../../all_cubit/login_cubit/cubit.dart';
import '../../all_cubit/shop_cubit/cubit_shop.dart';
import '../../style/iCONS.dart';

var formKey = GlobalKey<FormState>();

var phoneController = TextEditingController();
var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var passwordController = TextEditingController();
var emailController = TextEditingController();
var confirmPasswordController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Image? image1;

  @override
  void initState() {
    super.initState();
    image1 = Image.asset("assets/images/10_FEB_10.jpg");
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image1!.image, context);
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
          firstNameController.clear();
          lastNameController.clear();
          passwordController.clear();
          emailController.clear();
          confirmPasswordController.clear();
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
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top;
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
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: image1!.image,
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
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Sign up in our team now 👾',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: height * 0.035,
                          ),
                          //name form field
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your first name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Text("First name"),
                                    prefixIcon: Icon(
                                      IconBroken.Profile,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.035,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your last name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: Text("Last name"),
                                    prefixIcon: Icon(
                                      IconBroken.User,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
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
                              if (value.length != 11) {
                                return "enter a valid phone number";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: Text("Phone"),
                              prefixIcon: Icon(IconBroken.Call),
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
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey[500],
                              ),
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
                                return "please enter your password";
                              }
                              if (value.length < 8) {
                                return "password must be at least 8 characters or numbers";
                              }
                              if (!value.contains(RegExp(r'[a-z]')) &&
                                  !value.contains(RegExp(r'[A-Z]'))) {
                                return "password must contain at least one letter";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text("Password"),
                              prefixIcon: const Icon(IconBroken.Lock),
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
                                  LoginCubit.get(context).iconReg,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit.get(context).isPassReg,
                          ),
                          SizedBox(
                            height: height * 0.026,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your confirm password";
                              }
                              if (value != passwordController.text) {
                                return "password not match";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                String firstName = '';
                                String lastName = '';
                                (firstNameController.text.endsWith(' '))
                                    ? firstName = firstNameController.text
                                        .substring(
                                            0,
                                            firstNameController.text
                                                .lastIndexOf(' '))
                                        .toTitleCase()
                                    : firstName =
                                        firstNameController.text.toTitleCase();

                                (lastNameController.text.endsWith(' '))
                                    ? lastName = lastNameController.text
                                        .substring(
                                            0,
                                            lastNameController.text
                                                .lastIndexOf(' '))
                                        .toTitleCase()
                                    : lastName =
                                        lastNameController.text.toTitleCase();
                                LoginCubit.get(context).registerUser(
                                  name: '$firstName $lastName',
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              label: const Text("Confirm Password"),
                              prefixIcon: const Icon(IconBroken.Lock),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changeVisibilityPassConfirm();
                                },
                                icon: Icon(
                                  LoginCubit.get(context).iconConfirm,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit.get(context).isPassConfirm,
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
                                        String firstName = '';
                                        String lastName = '';
                                        (firstNameController.text.endsWith(' '))
                                            ? firstName = firstNameController
                                                .text
                                                .substring(
                                                    0,
                                                    firstNameController.text
                                                        .lastIndexOf(' '))
                                                .toTitleCase()
                                            : firstName = firstNameController
                                                .text
                                                .toTitleCase();

                                        (lastNameController.text.endsWith(' '))
                                            ? lastName = lastNameController.text
                                                .substring(
                                                    0,
                                                    lastNameController.text
                                                        .lastIndexOf(' '))
                                                .toTitleCase()
                                            : lastName = lastNameController.text
                                                .toTitleCase();
                                        LoginCubit.get(context).registerUser(
                                          name: '$firstName $lastName',
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        letterSpacing: 1.w,
                                        fontWeight: FontWeight.w600,
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
