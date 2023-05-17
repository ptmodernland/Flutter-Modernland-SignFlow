import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      print("login loading");
      await Future.delayed(Duration(seconds: 5));
      try {
        final request = await _loginRepository.login(event.payload);
        if (request) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: request.toString()));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}

