import 'package:modernland_signflow/bloc/login/login_response.dart';

abstract class LoginState {}

class AuthStateInitial extends LoginState {}

class AuthStateLoading extends LoginState {}

class AuthStateLoginSuccess extends LoginState {
  final UserDTO loginSuccessPayload;
  final String message;

  AuthStateLoginSuccess(
      {required this.loginSuccessPayload,
      this.message = "Selamat menggunakan aplikasi Modernland Approval"});
}

class AuthStateChangePinPasswordSuccess extends LoginState {
  final String message;

  AuthStateChangePinPasswordSuccess({this.message = ""});
}

class AuthStateLogoutSuccess extends LoginState {
  final String username;
  final String message;

  AuthStateLogoutSuccess({this.username = "", this.message = ""});
}

class AuthStateFailure extends LoginState {
  final String error;

  AuthStateFailure({required this.error});
}
