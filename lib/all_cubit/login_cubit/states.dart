
abstract class LoginState {}

class InitialState extends LoginState {}

class SuccessClear extends LoginState {}

class LoginSuccessState extends LoginState {
  final String myId;
  LoginSuccessState(this.myId);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({required this.error});
}

class CreateDataSuccessState extends LoginState {
  // final data;
  // CreateDataSuccessState(this.data);
}

class CreateDataErrorState extends LoginState {
  final String error;
  CreateDataErrorState({required this.error});
}

class LoginLoadingState extends LoginState {}

class ChangePassVisibilityState extends LoginState {}

class ChangePassVisibilityStateReg extends LoginState {}

class changeVisibilityPassConfirmm extends LoginState {}

class ChangeEmailSuccess extends LoginState {}

class ChangePassSuccess extends LoginState {}

class ShopRegisterLoadingState extends LoginState {}

class ShopRegisterSuccessState extends LoginState {
  final String model;
  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends LoginState {
  final String error;
  ShopRegisterErrorState({required this.error});
}
