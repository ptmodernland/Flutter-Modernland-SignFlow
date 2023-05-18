import 'package:bwa_cozy/bloc/login/login_payload.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final LoginPayload payload;

  LoginButtonPressed(this.payload);
}

class LoginButtonInit extends LoginEvent {
  LoginButtonInit();
}

class LogoutButtonPressed extends LoginEvent{
  final String username;

  LogoutButtonPressed(this.username);
}


