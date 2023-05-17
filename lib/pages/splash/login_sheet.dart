import 'package:bwa_cozy/pages/container_home.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/core/custom_text_input.dart';
import 'package:flutter/material.dart';

Future<dynamic> showLoginFormDialog(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController _usernameController,
    TextEditingController _passwordController) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;

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
              Text(
                "Silakan login menggunakan kredensial anda.",
                style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                  fontSize: setSubHeaderTextSize(screenWidth, screenHeight),
                ),
                textAlign: TextAlign.start,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      textEditController: _usernameController,
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
                      textEditController: _passwordController,
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
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            setButtonLoginRegisterPadding(context),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Text(
                          "Submit",
                          style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontSize: setButtonLoginRegisterSize(
                                  screenWidth, screenHeight),
                              color: Colors.white),
                        ),
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
                              return ContainerHomePage();
                            }));
                          }
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
      );
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



Alignment setLoginRegisterButtonAlignment(
    double screenWidth, double screenHeight) {
  return screenWidth >= 500 && screenHeight >= 700
      ? Alignment.centerLeft
      : Alignment.centerLeft;
}

double? setButtonLoginRegisterSize(double screenWidth, double screenHeight) {
  return screenWidth >= 500 && screenHeight > 700 ? 28.0 : 15;
}

AssetImage setFooterImage(double screenWidth, double screenHeight) {
  if (screenWidth < 500) {
    return AssetImage("asset/img/home/home_footer_mobile.png");
  } else {
    return AssetImage("asset/img/home/home_footer_landscape.png");
  }
}

