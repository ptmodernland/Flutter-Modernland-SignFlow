import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      print("login loading");
      try {
        final request = await _loginRepository.login(event.payload);
        if (request.data != null) {
          if (request is UserDTO) {
            emit(LoginSuccess(
                loginSuccessPayload: request.data!, //not null
                message: request.message ?? ""));
          } else {
            emit(LoginFailure(error: "Terjadi Kesalahan (error_code:168)"));
          }
        } else {
          emit(LoginFailure(error: request.message ?? ""));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString() ?? ""));
      }
    });
  }
}
