import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(AuthStateInitial()) {
    on<LoginButtonInit>((event, emit) async {
      emit(AuthStateLoading());
      print("login loading");
    });

    on<LogoutButtonPressed>((event, emit) async {
      emit(AuthStateLoading());
      print("logout loading");
      try {
        final request = await _loginRepository.unbindDevice(event.username);
        if (request.data != null) {
          emit(AuthStateLogoutSuccess(
              username: event.username, message: request.message ?? ""));
        } else {
          emit(AuthStateFailure(error: request.message ?? ""));
        }
      } catch (e) {
        emit(AuthStateFailure(error: e.toString() ?? ""));
      }
    });

    on<ChangePinPasswordEvent>((event, emit) async {
      emit(AuthStateLoading());
      print("bloc change password loading");
      try {
        final request = await _loginRepository.changePinPassword(
            newPassword: event.confirmNewPassword,
            password: event.newPassword,
            pin: event.newPin);
        if (request.data != null) {
          if(request.data==true){
            emit(
              AuthStateChangePinPasswordSuccess(message: request.message ?? ""),
            );
          }else{
            emit(
              AuthStateFailure(error: request.message ?? ""),
            );
          }
        } else {
          emit(AuthStateFailure(error: request.message ?? ""));
        }
      } catch (e) {
        emit(AuthStateFailure(error: e.toString() ?? ""));
      }
    });

    on<LoginButtonPressed>((event, emit) async {
      emit(AuthStateLoading());
      print("login loading");
      try {
        final request = await _loginRepository.login(event.payload);
        if (request.data != null) {
          emit(AuthStateLoginSuccess(
              loginSuccessPayload: request.data!, //not null
              message: request.message ?? ""));
        } else {
          emit(AuthStateFailure(error: request.message ?? ""));
        }
      } catch (e) {
        emit(AuthStateFailure(error: e.toString() ?? ""));
      }
    });
  }
}
