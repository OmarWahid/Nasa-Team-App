import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../shared/component.dart';
import '../../style/iCONS.dart';

var controllerBio = TextEditingController();
var controllerPhone = TextEditingController();
var controllerName = TextEditingController();

var keyForm = GlobalKey<FormState>();

class UpdateScreen_ extends StatelessWidget {
  const UpdateScreen_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        if (state is SuccessUpdateTextData) {
          Fluttertoast.showToast(
            msg: 'Update Successfully ✔',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
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
          title: const Text('Edit Account',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
          leading: Padding(
            padding:  EdgeInsets.only(
              left: 22.w,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
            ),
          ),
        );

        if (state is LoadingCompressPhoto) {
          return Scaffold(
            appBar: appBar,
            body: Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 22.w, right: 22.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('image compression and uploading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.sp,
                            height: 1.h,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CircleAvatar(
                      radius: 80.r,
                      child: LiquidCircularProgressIndicator(
                        value: 0.43,
                        // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                        // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors.white,
                        // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.deepPurple[300],
                        borderWidth: 4.w,
                        direction: Axis.vertical,
                        // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text("Loading...",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is LoadingGetUserData) {
          return Scaffold(
            appBar: appBar,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          );
        }

        controllerBio.text = NasaCubit.get(context).userData!.bio!;
        controllerPhone.text = NasaCubit.get(context).userData!.phone!;
        controllerName.text = NasaCubit.get(context).userData!.name!;
        var image = NasaCubit.get(context).profileImage;

        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context, 'refresh');
            return Future.value(false);
          },
          child: Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.w, 50.h, 20.w, 20.h),
                child: Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 126.h,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 71.r,
                                backgroundColor: Colors.deepPurple,
                                child: CircleAvatar(
                                  radius: 68.r,
                                  backgroundColor: Colors.white,
                                  backgroundImage: image == null
                                      ? CachedNetworkImageProvider(
                                          NasaCubit.get(context)
                                              .userData!
                                              .image!)
                                      : FileImage(image) as ImageProvider,
                                )),
                            CircleAvatar(
                                radius: 17.r,
                                backgroundColor: Colors.deepPurple,
                                child: FittedBox(
                                  child: IconButton(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                          msg: 'Plz select image size 1:1',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 5,
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        NasaCubit.get(context).getProfileData();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      TextFormField(
                        controller: controllerName,
                        onFieldSubmitted: (value) {},
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          prefixIcon: Icon(IconBroken.Profile),
                          labelText: 'Name',
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: controllerBio,
                        onFieldSubmitted: (value) {},
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your bio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          prefixIcon: Icon(IconBroken.Info_Circle),
                          labelText: 'Bio',
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: controllerPhone,
                        onFieldSubmitted: (value) {},
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          prefixIcon: Icon(IconBroken.Calling),
                          labelText: 'Phone',
                        ),
                      ),
                      if (state is LoadingGetUserData)
                        const SizedBox(height: 24),
                      if (state is LoadingGetUserData)
                        LinearProgressIndicator(color: Colors.deepPurple),
                      SizedBox(height: 32.h),
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            NasaCubit.get(context).updateUserText(
                                name: controllerName.text,
                                bio: controllerBio.text,
                                phone: controllerPhone.text);
                          },
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
