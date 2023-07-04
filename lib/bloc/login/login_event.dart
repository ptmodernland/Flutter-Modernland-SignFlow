import 'package:modernland_signflow/bloc/login/login_payload.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final LoginPayload payload;

  LoginButtonPressed(this.payload);
}

class LoginButtonInit extends LoginEvent {
  LoginButtonInit();
}

class LogoutButtonPressed extends LoginEvent {
  final String username;

  LogoutButtonPressed(this.username);
}

class ChangePinPasswordEvent extends LoginEvent {
  final String? newPassword;
  final String? confirmNewPassword;
  final String? newPin;

  ChangePinPasswordEvent({this.newPassword, this.confirmNewPassword, this.newPin});
}
