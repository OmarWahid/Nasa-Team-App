import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/all_cubit/login_cubit/states.dart';

import '../../model/login_model.dart';
import '../../network/cache_helper.dart';

import 'package:nasa_app/shared/component.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void loginUser({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print(user.user!.email);
      emit(LoginSuccessState(
         user.user!.uid,
      ));
    }).catchError((error) {


      emit(LoginErrorState(error:  error.message));
    });
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId=value.user!.uid;

      createUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      CacheHelper.saveData(
        key: 'uId',
        value: value.user!.uid,
      );
    }).catchError((error) {
      emit(ShopRegisterErrorState(error: error.message));
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,

  }) {
    SocialModel socialModel = SocialModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isVar: false,
      bio: 'write bio ...',
      image: 'https://img.freepik.com/free-vector/alien-head-with-glitch-effect_225004-653.jpg?w=740&t=st=1660751691~exp=1660752291~hmac=dc96f3669e918a53af44e5d11df66dec2bc6b935449ab5fb3b01e50d163d3dbd',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
      socialModel.toJson(),
    )
        .then((value) {
      emit(CreateDataSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(CreateDataErrorState(error: error.toString()));
    });
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeVisibilityPass() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePassVisibilityState());
  }

  bool isPassReg = true;
  IconData iconReg = Icons.visibility_outlined;

  void changeVisibilityPassReg() {
    isPassReg = !isPassReg;
    iconReg =
        isPassReg ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePassVisibilityStateReg());
  }
}
