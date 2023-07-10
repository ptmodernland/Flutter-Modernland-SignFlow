import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modernland_signflow/bloc/login/login_bloc.dart';
import 'package:modernland_signflow/bloc/login/login_event.dart';
import 'package:modernland_signflow/bloc/login/login_state.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/di/service_locator.dart';
import 'package:modernland_signflow/repos/login_repository.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/widget/core/blurred_dialog.dart';
import 'package:modernland_signflow/widget/core/custom_text_input.dart';
import 'package:quickalert/quickalert.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    LoginRepository loginRepository =
        LoginRepository(dioClient: getIt<DioClient>());
    loginBloc = LoginBloc(loginRepository);
  }

  @override
  Widget build(BuildContext context) {
    var username = "";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;


    String getUserRole(String role) {
      if (role == 'head') {
        return 'Head of Division/Department';
      } else if (role == 'shead') {
        return 'Komisaris/Direktur/C-Level';
      } else {
        return 'Administrasi';
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (BuildContext context) {
            return loginBloc;
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is AuthStateFailure) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          print("auth state is error");
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: state.error.toString(),
                              showCancelBtn: false,
                              title: "Error",
                              autoCloseDuration: Duration(seconds: 3));
                        }
                        if (state is AuthStateLoading) {
                          print("auth state is loading");
                        }
                        if (state is AuthStateChangePinPasswordSuccess) {
                          print("auth state is success");
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              showCancelBtn: false,
                              title: "Berhasil Mengganti PIN",
                              autoCloseDuration: Duration(seconds: 3));
                        }
                      },
                      child: Container(),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              image: DecorationImage(
                                image: AssetImage(
                                    'asset/img/background/bg_pattern_fp.png'),
                                repeat: ImageRepeat.repeat,
                              ),
                            ),
                            width: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Ganti Pin",
                                    style: MyTheme.myStylePrimaryTextStyle
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.0)),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomTextInput(
                                          textEditController:
                                              _newPasswordController,
                                          hintTextString: 'Masukkan Pin Baru (4 digit)',
                                          inputType: InputType.Number,
                                          enableBorder: true,
                                          themeColor:
                                              Theme.of(context).primaryColor,
                                          cornerRadius: 18.0,
                                          textValidator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Isi field ini terlebih dahulu';
                                            }
                                            if (double.tryParse(value) == null) {
                                              return 'Masukkan angka valid';
                                            }
                                            return null;
                                          },
                                          maxLength: 4,
                                          textColor: Colors.black,
                                          errorMessage:
                                              'Username cant be empty',
                                          labelText: 'Pin',
                                        ),
                                        SizedBox(height: 5),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                    if (state is AuthStateLoading) {
                                      return Text("Loading");
                                    }

                                    if (state is AuthStateFailure) {
                                      return Text("Error ");
                                    }

                                    if (state
                                        is AuthStateChangePinPasswordSuccess) {}
                                    return Container();
                                  }),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState?.validate() ??
                                          true) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CupertinoAlertDialog(
                                            title: Text("Ganti Pin"),
                                            content: Text(
                                                "Anda yakin ingin mengganti pin anda ?"),
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: Text("Batal",
                                                    style: TextStyle(
                                                        color: Colors.red)),
                                                onPressed: () {
                                                  // Perform any action here
                                                  // Dismiss the dialog
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text("Ya, Simpan",
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                                onPressed: () {
                                                  loginBloc.add(
                                                      ChangePinPasswordEvent(
                                                    newPin:
                                                        _newPasswordController
                                                            .text,
                                                  ));
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        print("error");
                                      }
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.black, width: 1),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 15),
                                        // Add some spacing between the icon and text
                                        Text(
                                          "Simpan Perubahan",
                                          style: MyTheme
                                              .myStyleSecondaryTextStyle
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                  if (state is AuthStateLoading) {
                    BlurredDialog(loadingText: "Mengupdate Password");
                  }
                  return Container();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
