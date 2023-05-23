import 'package:bwa_cozy/bloc/login/login_bloc.dart';
import 'package:bwa_cozy/bloc/login/login_event.dart';
import 'package:bwa_cozy/bloc/login/login_response.dart';
import 'package:bwa_cozy/bloc/login/login_state.dart';
import 'package:bwa_cozy/bloc/notif/notif_bloc.dart';
import 'package:bwa_cozy/bloc/notif/notif_event.dart';
import 'package:bwa_cozy/pages/profile/changepin/change_password_page.dart';
import 'package:bwa_cozy/pages/profile/changepin/change_pin_page.dart';
import 'package:bwa_cozy/pages/splash/splash_screen.dart';
import 'package:bwa_cozy/repos/login_repository.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/storage/sessionmanager/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';

class ProfilePage extends StatefulWidget {
  final NotifCoreBloc? notifBloc;

  const ProfilePage({Key? key, this.notifBloc = null}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // this.widget.notifBloc?.add(NotifEventCount());
  }

  @override
  Widget build(BuildContext context) {
    var username = "";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    LoginRepository loginRepository = LoginRepository();
    final loginBloc = LoginBloc(loginRepository);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
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
                        height: 210,
                        width: double.infinity,
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
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: state.message.toString(),
                              onConfirmBtnTap: (){
                                SessionManager.removeUserFromSession();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => SplashScreenPage(),
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
                            );
                          }
                          if (state is AuthStateFailure) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.loading,
                                text: "Sedang logout dari aplikasi",
                                showCancelBtn: false,
                                title: "Loading",
                                autoCloseDuration: Duration(seconds: 3));
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
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "General",
                                style:
                                    MyTheme.myStylePrimaryTextStyle.copyWith(),
                              ),
                              ProfileMenuItemWidget(
                                onClick: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ChangePasswordPage();
                                  }));
                                },
                                title: "Ganti Password",
                                description:
                                    "Ganti Password Yang Digunakan Untuk Login",
                                imageAsset:
                                    "asset/img/icons/icon_security_shield.svg",
                              ),
                              ProfileMenuItemWidget(
                                onClick: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return ChangePinPage();
                                  }));
                                },
                                title: "Ganti PIN",
                                description:
                                    "Ganti pin yang digunakan untuk approval/reject dokumen",
                                imageAsset:
                                    "asset/img/icons/icon_security_shield.svg",
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: double.infinity,
                                child:
                                ElevatedButton(
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
                                                child: Text("Kembali ke Aplikasi"),
                                                onPressed: () {
                                                  // Perform any action here
                                                  // Dismiss the dialog
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text("Ya"),
                                                onPressed: () {
                                                  loginBloc.add(LogoutButtonPressed(
                                                      username));
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
                                          style: MyTheme
                                              .myStyleSecondaryTextStyle
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
                                    "http://feylabs.my.id/music/assets/album/1c8f05a2cd0464a2216b0b6c20ddb50d.jpg",
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
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          user.nama,
                                          style: MyTheme.myStylePrimaryTextStyle
                                              .copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                        Text('(${getUserRole(user.level)})'),
                                        Text(
                                          user.email,
                                          style:
                                              MyTheme.myStyleSecondaryTextStyle,
                                        ),
                                        Text('Username: ${user.username}'),
                                      ],
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
      ),
    );
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