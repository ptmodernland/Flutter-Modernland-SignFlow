import 'package:bwa_cozy/pages/splash/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ModernlandInitialPage extends StatefulWidget {
  const ModernlandInitialPage({Key? key}) : super(key: key);

  @override
  State<ModernlandInitialPage> createState() => _ModernlandInitialPageState();
}

class _ModernlandInitialPageState extends State<ModernlandInitialPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    init();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );
    _animationController!.forward();
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigation to next page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreenPage()),
        );
      }
    });
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
    print("#######" + deviceToken);
    print("############################################################");

    // listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;

      //im gonna have an alertdialog when clicking from push notification
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: (title ?? "") + (description ?? ""),
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FCM Message data: ${message.data}");
      if (message.notification != null) {
        print("FCM Message notification: ${message.notification}");
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  //get device token to use for push notification
  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color here
      body: Center(
        child: ScaleTransition(
          scale: _animation!,
          child: Expanded(
            flex: MediaQuery.of(context).size.width > 600 ? 3 : 10,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Image.asset(
                  "asset/img/icons/logo_modernland.png",
                  width: constraints.maxWidth,
                );
              },
            ),
          ), // Replace with your logo image
        ),
      ),
    );
  }
}
