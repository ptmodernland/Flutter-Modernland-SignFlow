import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:bwa_cozy/pages/container_home.dart';
import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/core/custom_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:bwa_cozy/util/model/device_information_model.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:bwa_cozy/bloc/login/login_bloc.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';

Future<dynamic> showLoginFormDialog({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController usernameController,
  required TextEditingController passwordController,
  required LoginBloc loginBloc,
  required LoginRepository loginRepo,
}) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: BlocProvider(
            create: (BuildContext context) {
              return loginBloc;
            },
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        // Navigate to next screen

                        if(state is AuthStateLogoutSuccess){
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: state.message.toString(),
                          );
                        }
                        if (state is AuthStateLoginSuccess) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: state.message.toString(),
                          );


                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ContainerHomePage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 1500),
                            ),
                                (route) => false,
                          );
                        }

                        if (state is AuthStateFailure) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: state.error.toString(),
                          );
                        }
                      },
                      child: Container(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex:
                              MediaQuery.of(context).size.width > 600 ? 3 : 10,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Image.asset(
                                "asset/img/icons/logo_modernland.png",
                                width: constraints.maxWidth,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: MediaQuery.of(context).size.width > 600 ? 7 : 3,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    Text(
                      "Silakan login menggunakan kredensial anda.",
                      style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                        color: Colors.black,
                        fontSize:
                            setSubHeaderTextSize(screenWidth, screenHeight),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextInput(
                            textEditController: usernameController,
                            hintTextString: 'Username',
                            inputType: InputType.Default,
                            enableBorder: true,
                            themeColor: Theme.of(context).primaryColor,
                            cornerRadius: 18.0,
                            textValidator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Input Username terlebih dahulu';
                              }
                              return null;
                            },
                            maxLength: 900,
                            prefixIcon: Icon(Icons.lock_clock_outlined,
                                color: Theme.of(context).primaryColor),
                            textColor: Colors.black,
                            errorMessage: 'Username cant be empty',
                            labelText: 'Username',
                          ),
                          SizedBox(height: 5),
                          CustomTextInput(
                            textEditController: passwordController,
                            hintTextString: 'Enter Password',
                            inputType: InputType.Password,
                            enableBorder: true,
                            textValidator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Input Password terlebih dahulu';
                              }
                              return null;
                            },
                            themeColor: Theme.of(context).primaryColor,
                            cornerRadius: 18.0,
                            maxLength: 900,
                            prefixIcon: Icon(Icons.lock_clock_outlined,
                                color: Theme.of(context).primaryColor),
                            textColor: Colors.black,
                            errorMessage: 'Password cant be empty',
                            labelText: 'Password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is AuthStateFailure) {
                                return Column(
                                  children: [
                                    Text(
                                      state.error,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Klik untuk unbind device",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onTap: () {
                                        loginBloc.add(LogoutButtonPressed(
                                            usernameController.text));
                                      },
                                    )
                                  ],
                                );
                              }

                              return Container();
                            },
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is AuthStateInitial) {
                                  return showLoginButton(
                                      context,
                                      screenWidth,
                                      screenHeight,
                                      formKey,
                                      usernameController,
                                      passwordController,
                                      loginBloc);
                                }

                                if (state is AuthStateLoading) {
                                  Container(
                                    width: screenWidth * 0.1,
                                    child: Center(
                                      child: CupertinoActivityIndicator(
                                        animating: true,
                                      ),
                                    ),
                                  );
                                }

                                if (state is AuthStateFailure) {
                                  return showLoginButton(
                                      context,
                                      screenWidth,
                                      screenHeight,
                                      formKey,
                                      usernameController,
                                      passwordController,
                                      loginBloc);
                                }

                                if (state is AuthStateLoginSuccess ||
                                    state is AuthStateLogoutSuccess) {
                                  return showLoginButton(
                                      context,
                                      screenWidth,
                                      screenHeight,
                                      formKey,
                                      usernameController,
                                      passwordController,
                                      loginBloc);
                                }

                                return Container(
                                  width: screenWidth * 0.1,
                                  child: Center(
                                    child: CupertinoActivityIndicator(
                                      animating: true,
                                    ),
                                  ),
                                );
                                ;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Widget showLoginButton(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    GlobalKey<FormState> _formKey,
    TextEditingController _usernameController,
    TextEditingController _passwordController,
    LoginBloc loginBloc) {
  return ElevatedButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        setButtonLoginRegisterPadding(context),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.transparent),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
    child: Text(
      "Submit",
      style: MyTheme.myStylePrimaryTextStyle.copyWith(
          fontSize: setButtonLoginRegisterSize(screenWidth, screenHeight),
          color: Colors.white),
    ),
    onPressed: () async {
      if (_formKey.currentState?.validate() ?? true) {
        // Perform login or submit logic here
        // You can access the entered username and password using
        // _usernameController.text and _passwordController.text
        print('Username: ${_usernameController.text}');
        print('Password: ${_passwordController.text}');
        // Close the bottom sheet
        loginBloc.add(LoginButtonInit());
        var deviceInfo = await getDeviceInfo();
        if (deviceInfo != null) {
          final payload = LoginPayload(
            username: _usernameController.text,
            password: _passwordController.text,
            address: deviceInfo.ipAddress,
            brand: deviceInfo.brand,
            ip: deviceInfo.ipAddress,
            model: deviceInfo.model,
            phonetype: deviceInfo.deviceType,
            // token: TODO ADD FIREBASE TOKEN
          );
          loginBloc.add(LoginButtonPressed(payload));
        } else {
          final payload = LoginPayload(
            username: _usernameController.text,
            password: _passwordController.text,
            // token: TODO ADD FIREBASE TOKEN
          );
          loginBloc.add(LoginButtonPressed(payload));
        }
      }
    },
  );
}

double setSubHeaderTextSize(double screenWidth, double screenHeight) {
  if (screenWidth >= 500 && screenHeight > 700) {
    return 18.0;
  } else {
    return 14.0;
  }
}

openwhatsapp(BuildContext context, String number) async {
  var whatsapp = "+" + number;
  var whatsappURl_android =
      "whatsapp://send?phone=" + whatsapp + "&text=Permintaan+reset+sandi";
  var whatappURL_ios =
      "https://wa.me/$whatsapp?text=${Uri.parse("Permintaan+reset+sandi")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("WhatsApp tidak terpasang")));
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("WhatsApp tidak terpasang")));
    }
  }
}

Future<DeviceInformationModel> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceType = '';
  String model = '';
  String brand = '';
  String ipAddress = '';

  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceType = 'Android';
      model = androidInfo.model ?? "";
      brand = androidInfo.brand ?? "";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceType = 'iOS';
      model = iosInfo.model ?? "Iphone";
      brand = iosInfo.name ?? "Iphone";
    }

    while (ipAddress.isEmpty) {
      try {
        ipAddress = await getIpAddress();
      } catch (e) {
        // Ignore the exception and continue the loop
      }
    }
  } catch (e) {
    return DeviceInformationModel(
      deviceType: 'Unknown',
      model: 'Unknown',
      brand: 'Unknown',
      ipAddress: 'Unknown',
    );
  }

  return DeviceInformationModel(
    deviceType: deviceType,
    model: model,
    brand: brand,
    ipAddress: ipAddress,
  );
}

Future<String> getIpAddress() async {
  final ipv4 = await Ipify.ipv4();
  final address = InternetAddress(ipv4);
  print("IP address is " + address.address.toString());
  return address.address.toString();
}

EdgeInsets setButtonLoginRegisterPadding(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  print("screen height : $screenHeight");
  print("screen width : $screenWidth");

  if (screenWidth >= 500 && screenHeight > 600) {
    return EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width > 500 ? 10.0 : 8.5,
        horizontal: MediaQuery.of(context).size.width > 500 ? 25.0 : 10.0);
  } else {
    return EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width > 500 ? 15.0 : 8.5,
        horizontal: MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0);
  }

  return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.width > 500 ? 15.0 : 8.5,
      horizontal: MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0);
}

Alignment setLoginRegisterButtonAlignment(
    double screenWidth, double screenHeight) {
  return screenWidth >= 500 && screenHeight >= 700
      ? Alignment.centerLeft
      : Alignment.centerLeft;
}

double? setButtonLoginRegisterSize(double screenWidth, double screenHeight) {
  if (screenWidth > 500 && screenWidth < 1000) {
    return 15;
  }

  if (screenHeight > 500 && screenWidth > 1000) {
    return 15;
  }

  return screenWidth >= 500 && screenHeight > 700 ? 25.0 : 15;
}

AssetImage setFooterImage(double screenWidth, double screenHeight) {
  if (screenWidth < 500) {
    return AssetImage("asset/img/home/home_footer_mobile.png");
  } else {
    return AssetImage("asset/img/home/home_footer_landscape.png");
  }
}

double setHeaderTextSize(double screenWidth, double screenHeight) {
  if (screenWidth >= 500 && screenHeight > 700) {
    return 28.0;
  } else {
    return 22.0;
  }
}
