import 'dart:ui';
import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  EdgeInsets setButtonLoginRegisterPadding(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 500 && screenHeight > 600) {
      EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width > 500 ? 15.0 : 8.5,
          horizontal: MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0);
    } else {
      EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width > 500 ? 15.0 : 8.5,
          horizontal: MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0);
    }

    return EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width > 500 ? 15.0 : 8.5,
        horizontal: MediaQuery.of(context).size.width > 500 ? 50.0 : 25.0);
  }

  double? setButtonLoginRegisterSize(double screenWidth, double screenHeight) {
    return screenWidth >= 500 && screenHeight > 700 ? 28.0 : 24;
  }

  double setHeaderTextSize(double screenWidth, double screenHeight) {
    if (screenWidth >= 500 && screenHeight > 700) {
      return 28.0;
    } else {
      return 22.0;
    }
  }

  Alignment setLoginRegisterButtonAlignment(
      double screenWidth, double screenHeight) {
    return screenWidth >= 500 && screenHeight >= 700
        ? Alignment.centerLeft
        : Alignment.centerLeft;
  }

  double setSubHeaderTextSize(double screenWidth, double screenHeight) {
    if (screenWidth >= 500 && screenHeight > 700) {
      return 18.0;
    } else {
      return 12.0;
    }
  }

  AssetImage setFooterImage(double screenWidth, double screenHeight) {
    if (screenWidth < 500) {
      return AssetImage("asset/img/home/home_footer_mobile.png");
    } else {
      return AssetImage("asset/img/home/home_footer_landscape.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                        Image.asset(
                          "asset/img/icons/logo_modernland.png",
                          width: screenWidth * 0.5,
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
                                  showLoginFormDialog(context, _formKey,
                                      _usernameController, _passwordController);
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
                                      side:
                                          BorderSide(color: Colors.transparent),
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
                                          fontSize: setButtonLoginRegisterSize(
                                              screenWidth, screenHeight),
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
                Row(
                  children: [
                    Expanded(
                      flex: MediaQuery.of(context).size.width > 600 ? 3 : 10,
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
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showLoginFormDialog(
      BuildContext context,
      GlobalKey<FormState> _formKey,
      TextEditingController _usernameController,
      TextEditingController _passwordController) {
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
                Row(
                  children: [
                    Expanded(
                      flex: MediaQuery.of(context).size.width > 600 ? 3 : 10,
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
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          // border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          // border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? true) {
                            // Perform login or submit logic here
                            // You can access the entered username and password using
                            // _usernameController.text and _passwordController.text
                            print('Username: ${_usernameController.text}');
                            print('Password: ${_passwordController.text}');
                            // Close the bottom sheet
                            Navigator.pop(context);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
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
