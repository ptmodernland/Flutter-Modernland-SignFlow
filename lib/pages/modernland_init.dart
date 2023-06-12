import 'package:bwa_cozy/pages/splash/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModernlandInitialPage extends StatefulWidget {
  const ModernlandInitialPage({Key? key}) : super(key: key);

  @override
  State<ModernlandInitialPage> createState() => _ModernlandInitialPageState();
}

class _ModernlandInitialPageState extends State<ModernlandInitialPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    init();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
    );
    _animationController.forward().whenComplete(() {
      // Navigation to next page after 5 seconds
      navigateToNextPage();
    });
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ######");
    print("#######" + deviceToken);
    print("############################################################");

    // Save the token into SharedPreferences
    saveTokenToDevice(deviceToken);

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
    _animationController.dispose();
    super.dispose();
  }

  //get device token to use for push notification
  Future<String> getDeviceToken() async {
    //request user permission for push notification
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      badge: true,
      provisional: false,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );

    await FirebaseMessaging.onMessage.listen((event) {});

    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return deviceToken ?? "";
  }

  // Save the device token into SharedPreferences
  Future<void> saveTokenToDevice(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceToken', token);
  }

  void navigateToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SplashScreenPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color here
      body: Center(
        child: ScaleTransition(
          scale: _animation,
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