import 'package:bwa_cozy/bloc/login/login_bloc.dart';
import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:bwa_cozy/widget/core/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginNewPage extends StatefulWidget {
  @override
  State<LoginNewPage> createState() => _LoginNewPageState();
}

class _LoginNewPageState extends State<LoginNewPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginRepository loginRepository = LoginRepository();
    final loginBloc = LoginBloc(loginRepository);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (context) => loginBloc,
        child: Column(
          children: [
            CustomTextInput(
              textEditController: usernameController,
              hintTextString: 'Enter User name',
              inputType: InputType.Default,
              enableBorder: true,
              themeColor: Theme.of(context).primaryColor,
              cornerRadius: 48.0,
              maxLength: 24,
              prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor),
              textColor: Colors.black,
              errorMessage: 'User name cannot be empty',
              labelText: 'User Name',
            ),
            CustomTextInput(
              textEditController: passwordController,
              hintTextString: 'Enter User name',
              inputType: InputType.Password,
              enableBorder: true,
              themeColor: Theme.of(context).primaryColor,
              cornerRadius: 48.0,
              maxLength: 24,
              prefixIcon: Icon(Icons.lock_clock_outlined, color: Theme.of(context).primaryColor),
              textColor: Colors.black,
              errorMessage: 'Password cant be empty',
              labelText: 'Password',
            ),
            ElevatedButton(
              onPressed: () {
                final payload = LoginPayload(
                    username: usernameController.text,
                    password: passwordController.text,
                );
                loginBloc.add(LoginButtonPressed(payload));
              },
              child: Text('Login'),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is AuthStateInitial) {
                  return Text("Silakan Masukkan Username dan Password");
                }
                if (state is AuthStateLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AuthStateFailure) {
                  return Column(
                    children: [
                      Text('Login failed: ${state.error}'),
                      ElevatedButton(
                        onPressed: () {
                          final payload = LoginPayload(
                            username: usernameController.text,
                            password: passwordController.text,
                          );
                          loginBloc.add(LoginButtonPressed(payload));
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  );
                } else if (state is AuthStateLoginSuccess) {
                  return Text('Login successful!');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}