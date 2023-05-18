import 'dart:ui';
import 'package:bwa_cozy/bloc/login/login_bloc.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/pages/container_home.dart';
import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/pages/login_new_page.dart';
import 'package:bwa_cozy/pages/splash/login_sheet.dart';
import 'package:bwa_cozy/util/model/device_information_model.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:bwa_cozy/repos/login_repository.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}


class _SplashScreenPageState extends State<SplashScreenPage> {

  void checkUserAndNavigate() async {
    UserDTO? user = await SessionManager.getUser();
    if (user != null) {
      print("user is logged in as "+ user.username);
      navigateToHomePage();
    } else {
      print("user is not logged in");
      // Handle the case when user is not available
      // For example, show a login screen or a splash screen
    }
  }

  void navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ContainerHomePage()),
          (route) => false, // This will remove all routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    DeviceInformationModel deviceInformation;

    @override
    void initState() {
      super.initState();
      checkUserAndNavigate();
    }

    LoginRepository loginRepository = LoginRepository();
    final loginBloc = LoginBloc(loginRepository);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    checkUserAndNavigate();


    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image(
                  image: setFooterImage(screenWidth, screenHeight),
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  // Specify the desired height of the image
                  fit: BoxFit.cover,
                  // Adjust the fit of the image within its container
                  alignment: Alignment.center,
                  // Align the image within its container
                  // color: Colors.red, // Apply a color filter to the image
                  colorBlendMode: BlendMode.multiply,
                  // Specify the blend mode for the color filter
                  // repeat: ImageRepeat.repeat, // Specify how the image should be repeated
                  filterQuality:
                      FilterQuality.high, // Set the filter quality of the image
                ),
              ),
              Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       image: NetworkImage('your image url'),
                //       fit: BoxFit.cover
                //   ),
                // ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            "asset/img/icons/logo_modernland.png",
                            width: screenWidth * 0.5,
                          ),
                          onDoubleTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginNewPage();
                            }));
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              style: MyTheme.myStylePrimaryTextStyle.copyWith(
                                fontSize: setHeaderTextSize(
                                    screenWidth, screenHeight),
                              ),
                              children: [
                                TextSpan(text: "Maximizing "),
                                TextSpan(
                                  text: "Performance ",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                    fontSize: setHeaderTextSize(
                                        screenWidth, screenHeight),
                                    // Adjust the font size for large screens
                                    fontWeight: MyTheme.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "To\n",
                                ),
                                TextSpan(
                                  text: "Growth ",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                    fontSize: setHeaderTextSize(
                                        screenWidth, screenHeight),
                                    fontWeight: MyTheme.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "and ",
                                ),
                                TextSpan(
                                  text: "Development ",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                    fontSize: setHeaderTextSize(
                                        screenWidth, screenHeight),
                                    fontWeight: MyTheme.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Modernland Approval revolutionizes the approval process, empowering efficient decision-making and expediting critical assessments.",
                            style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                              fontSize: setSubHeaderTextSize(
                                  screenWidth, screenHeight),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: setLoginRegisterButtonAlignment(
                              screenWidth, screenHeight),
                          child: Wrap(
                            spacing: 2,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showLoginFormDialog(
                                      context: context,
                                      formKey: _formKey,
                                      loginBloc: loginBloc,
                                      loginRepo: loginRepository,
                                      passwordController:
                                      _passwordController,
                                      usernameController:
                                      _usernameController);
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsets>(
                                    setButtonLoginRegisterPadding(
                                        context),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent),
                                    ),
                                  ),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.black),
                                ),
                                child: Text(
                                  "Login",
                                  style: MyTheme.myStylePrimaryTextStyle
                                      .copyWith(
                                      fontSize:
                                      setButtonLoginRegisterSize(
                                          screenWidth,
                                          screenHeight),
                                      color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showForgotPasswordDialog(context);
                                },
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    setButtonLoginRegisterPadding(context),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: Text(
                                  "Lupa Password",
                                  style:
                                      MyTheme.myStylePrimaryTextStyle.copyWith(
                                    fontSize: setButtonLoginRegisterSize(
                                      screenWidth,
                                      screenHeight,
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.asset(
                                        "asset/img/icons/logo_modernland.png",
                                        width: screenWidth * 0.1,
                                      ),
                                      Text(
                                        'Device Information',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      FutureBuilder(
                                        future: getDeviceInfo(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(snapshot
                                                        .data?.deviceInfoString
                                                        .toString() ??
                                                    ""),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(
                                                        text: snapshot.data
                                                                ?.deviceInfoString ??
                                                            ""));
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.info,
                                                      text:
                                                          'Device information copied to clipboard : ' +
                                                              snapshot.data
                                                                  .toString(),
                                                    );
                                                  },
                                                  child:
                                                      Text("Copy to Clipboard"),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Text("Loading");
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "Lihat Informasi Device",
                              style: MyTheme.myStyleSecondaryTextStyle
                                  .copyWith(fontSize: 11),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<dynamic> showForgotPasswordDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
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
                      "Silakan klik salah satu nomor dibawah untuk permintaan reset password",
                      style: MyTheme.myStyleSecondaryTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        openwhatsapp(context, "+6282113530950");
                      },
                      child: Card(
                        color: Colors.green,
                        elevation: 4,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            "Henry Augusta",
                            style: MyTheme.myStyleSecondaryTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          subtitle: Text("082113530950"),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.kindpng.com/picc/m/19-195256_whatsapp-icon-whatsapp-logo-jpg-download-hd-png.png"),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openwhatsapp(context, "+6282113530950");
                      },
                      child: Card(
                        color: Colors.green,
                        elevation: 4,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            "Henry Augusta",
                            style: MyTheme.myStyleSecondaryTextStyle
                                .copyWith(color: Colors.white),
                          ),
                          subtitle: Text("082113530950"),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.kindpng.com/picc/m/19-195256_whatsapp-icon-whatsapp-logo-jpg-download-hd-png.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
