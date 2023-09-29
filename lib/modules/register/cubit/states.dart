import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final LoginModel model;
  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates{}

class RegisterChangePasswordVisibilityState extends RegisterStates{}