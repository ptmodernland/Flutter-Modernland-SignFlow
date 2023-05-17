import 'package:bwa_cozy/bloc/login/login_response.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserDTO loginSuccessPayload;
  final String message;

  LoginSuccess(
      {required this.loginSuccessPayload,
      this.message = "Selamat menggunakan aplikasi Modernland Approval"});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
