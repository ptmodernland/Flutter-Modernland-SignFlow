import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modernland_signflow/bloc/login/login_bloc.dart';
import 'package:modernland_signflow/bloc/login/login_event.dart';
import 'package:modernland_signflow/bloc/login/login_response.dart';
import 'package:modernland_signflow/bloc/login/login_state.dart';
import 'package:modernland_signflow/bloc/notif/notif_bloc.dart';
import 'package:modernland_signflow/data/dio_client.dart';
import 'package:modernland_signflow/di/service_locator.dart';
import 'package:modernland_signflow/pages/profile/changepin/change_password_page.dart';
import 'package:modernland_signflow/pages/profile/changepin/change_pin_page.dart';
import 'package:modernland_signflow/pages/splash/splash_screen.dart';
import 'package:modernland_signflow/repos/login_repository.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/util/storage/sessionmanager/session_manager.dart';
import 'package:modernland_signflow/widget/core/blurred_dialog.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final NotifCoreBloc? notifBloc;

  const ProfilePage({Key? key, this.notifBloc = null}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late LoginBloc loginBloc;
  late String username;
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(LoginRepository(dioClient: getIt<DioClient>()));
    username = "";
  }

  @override
  Widget build(BuildContext context) {
    var username = "";

    String getUserRole(String role) {
      if (role == 'head') {
        return 'Head of Division/Department';
      } else if (role == 'shead') {
        return 'Komisaris/Direktur/C-Level';
      } else if (role == 'staff') {
        return 'Administrasi';
      } else {
        return "Investor of MDLN";
      }
    }

    return SafeArea(
      top: false,
      child: Stack(
        children: [
          buildScaffold(context, username, getUserRole),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) {
              return loginBloc;
            },
            // Replace with your actual cubit instantiation
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                if (state is AuthStateLoading) {
                  return const BlurredDialog(loadingText: "Please Wait");
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Scaffold buildScaffold(
      BuildContext context, String username, String getUserRole(String role)) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (BuildContext context) {
          return loginBloc;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                      child: Image.asset(
                        "asset/img/icons/logo_modernland.png",
                        width: screenWidth * 0.2,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        image: DecorationImage(
                          image: AssetImage(
                              'asset/img/background/bg_pattern_fp.png'),
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      height: 200,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // Align the Row to the center-left
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                "Profile",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: MyTheme.myStylePrimaryTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
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
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Stack(
                  children: [
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is AuthStateLogoutSuccess) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              var text = "Logout Berhasil";
                              return CupertinoAlertDialog(
                                title: const Text(
                                  'Success',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(text),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      proceedLogoutLocally(context);
                                    },
                                    child: Text('OK',
                                        style: TextStyle(color: Colors.blue)),
                                  ),
                                ],
                              );
                            },
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
                    Container(
                      padding: EdgeInsets.only(top: 200),
                      width: double.infinity,
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: [
                          FutureBuilder<Widget>(
                            future: buildProfileMenuItemContainer(
                                context, loginBloc),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Show a loading indicator while waiting for the future to complete
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // Show an error message if the future encounters an error
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // Display the menu item widget
                                return snapshot.data!;
                              }
                            },
                          ),
                          buildHelpdeskSection(context),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    title: Text("Logout"),
                                    content: Text(
                                        "Anda akan keluar dari aplikasi ini. Apakah Anda yakin?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text(
                                          "Kembali ke Aplikasi",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          // Perform any action here
                                          // Dismiss the dialog
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text("Ya",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                        onPressed: () {
                                          loginBloc.add(
                                              LogoutButtonPressed(username));
                                          // Perform any action here
                                          // Dismiss the dialog
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: ButtonStyle(
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
                                        Colors.black),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      // Specify the logout icon here
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 15),
                                    // Add some spacing between the icon and text
                                    Text(
                                      "Logout",
                                      style: MyTheme.myStyleSecondaryTextStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                      child: Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      // Shadow color
                                      spreadRadius: 2,
                                      // Spread radius
                                      blurRadius: 5,
                                      // Blur radius
                                      offset: Offset(0,
                                          3), // Offset in the x and y direction
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  "https://img2.beritasatu.com/cache/beritasatu/910x580-2/1607910603.jpg",
                                  // Replace with your image URL
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            FutureBuilder<UserDTO?>(
                              future: SessionManager.getUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // While the future is loading, show a loading indicator or placeholder
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  UserDTO user = snapshot.data!;
                                  username = user.username;
                                  return Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            proceedLogoutLocally(context);
                                          },
                                          child: Text(
                                            user.nama,
                                            textAlign: TextAlign.center,
                                            style: MyTheme
                                                .myStylePrimaryTextStyle
                                                .copyWith(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w900),
                                          ),
                                        ),
                                        Text(
                                          '(${getUserRole(user.level)})',
                                          textAlign: TextAlign.center,
                                        ),
                                        if (user.email.isNotEmpty)
                                          Text(
                                            user.email,
                                            textAlign: TextAlign.center,
                                            style: MyTheme
                                                .myStyleSecondaryTextStyle,
                                          ),
                                        if (user.username.isNotEmpty)
                                          Text(
                                            'Username: ${user.username}',
                                            textAlign: TextAlign.center,
                                          ),
                                        SizedBox(
                                          height: 35,
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Text('User not found');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildHelpdeskSection(BuildContext context) {
    if (Platform.isIOS) {
      return Container();
    } else {
      return Container();
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Helpdesk SignFlow",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTheme.myStylePrimaryTextStyle.copyWith(),
                  ),
                  Text(
                    "Silakan hubungi salah satu nomor dibawah jika terjadi masalah dengan aplikasi SignFlow",
                    style: MyTheme.myStyleSecondaryTextStyle,
                  ),
                ],
              ),
            ),
            Column(
              children: [
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
                      subtitle: Text("0821-1353-0950"),
                      trailing: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.kindpng.com/picc/m/19-195256_whatsapp-icon-whatsapp-logo-jpg-download-hd-png.png"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openwhatsapp(context, "+6285780258444");
                  },
                  child: Card(
                    color: Colors.green,
                    elevation: 4,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        "Ardi Dzariat",
                        style: MyTheme.myStyleSecondaryTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      subtitle: Text("0857-8025-8444"),
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
      );
    }
  }

  Future<Widget> buildProfileMenuItemContainer(
      BuildContext context, LoginBloc loginBloc) async {
    var user = await SessionManager.getUser();
    var username = user?.username ?? "";
    if (user?.idUser == "-88") {
      return Container();
    }
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ProfileMenuItemWidget(
          onClick: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChangePasswordPage();
            }));
          },
          title: "Ganti Password",
          description: "Ganti Password Yang Digunakan Untuk Login",
          imageAsset: "asset/img/icons/icon_security_shield.svg",
        ),
        ProfileMenuItemWidget(
          onClick: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChangePinPage();
            }));
          },
          title: "Ganti PIN",
          description: "Ganti pin yang digunakan untuk approval/reject dokumen",
          imageAsset: "asset/img/icons/icon_security_shield.svg",
        ),
      ],
    );
  }

  void proceedLogoutLocally(BuildContext context) {
    SessionManager.removeUserFromSession();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SplashScreenPage(),
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

  openwhatsapp(BuildContext context, String number) async {
    var whatsapp = "+" + number;
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("")}";
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
}

class ProfileMenuItemWidget extends StatelessWidget {
  final Function? onClick;
  final String title;
  final String description;
  final String imageAsset;

  const ProfileMenuItemWidget({
    Key? key,
    this.onClick,
    this.title = "",
    this.description = "",
    this.imageAsset = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Color(0xFFEFF1F3),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  imageAsset,
                  width: double.infinity,
                  height: 20,
                  fit: BoxFit.contain,
                )),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MyTheme.myStylePrimaryTextStyle.copyWith(),
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MyTheme.myStylePrimaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
