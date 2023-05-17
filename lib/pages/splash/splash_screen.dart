import 'dart:ui';
import 'package:bwa_cozy/pages/container_home.dart';
import 'package:bwa_cozy/pages/login_new_page.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  openwhatsapp(String number) async {
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

  Future<String> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceInfo = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceInfo = 'Device Type: Android\n';
        deviceInfo += 'Model: ${androidInfo.model}\n';
        deviceInfo += 'Brand: ${androidInfo.brand}\n';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo = 'Device Type: iOS\n';
        deviceInfo += 'Model: ${iosInfo.model}\n';
        deviceInfo += 'Brand: ${iosInfo.name}\n';
      }

      String? ipAddress;
      while (ipAddress == null) {
        try {
          ipAddress = await getIpAddress();
        } catch (e) {
          // Ignore the exception and continue the loop
        }
      }

      deviceInfo += 'IP Address: $ipAddress';
    } catch (e) {
      deviceInfo = 'Failed to retrieve device information. because of $e';
    }

    return deviceInfo;
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
    return screenWidth >= 500 && screenHeight > 700 ? 28.0 : 15;
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
      return 14.0;
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
                        GestureDetector(
                          child: Image.asset(
                            "asset/img/icons/logo_modernland.png",
                            width: screenWidth * 0.5,
                          ),
                          onDoubleTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
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
                                                Text(snapshot.data ?? ""),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                snapshot.data ??
                                                                    ""));
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.info,
                                                      text:
                                                          'Device information copied to clipboard : '+snapshot.data.toString(),
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
                        openwhatsapp("+6282113530950");
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
                        openwhatsapp("+6282113530950");
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
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
                              return ContainerHomePage();
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
