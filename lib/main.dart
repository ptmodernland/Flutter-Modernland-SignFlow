import 'package:bwa_cozy/di/service_locator.dart';
import 'package:bwa_cozy/pages/approval/compare/detail_compare_page.dart';
import 'package:bwa_cozy/pages/approval/iom/iomdetail/iom_detail_page.dart';
import 'package:bwa_cozy/pages/approval/kasbon/kasbon_detail_page.dart';
import 'package:bwa_cozy/pages/approval/pbj/detail_pbj_page.dart';
import 'package:bwa_cozy/pages/approval/realisasi/realisasi_detail_page.dart';
import 'package:bwa_cozy/pages/modernland_init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase from Firebase Core plugin
  await Firebase.initializeApp();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ######");
    print("#######" + deviceToken);
    print("############################################################");

    // Save the token into SharedPreferences
    saveTokenToDevice(deviceToken);

    // Listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;
      print("168888");
      Fluttertoast.showToast(msg: "assalamualaikum");
      print("168999");

      // Read the target value from the data payload
      String? target = remoteMessage.data['target'];
      String? noPermintaan = remoteMessage.data['no_permintaan'];
      String? noKasbon = remoteMessage.data['nomornya'];
      String? idKasbon = remoteMessage.data['idnya'];

      String? noCompare = remoteMessage.data['nomornya'];
      String? noRealisasi = remoteMessage.data['nomornya'];
      String? noIOM = remoteMessage.data['nomornya'];
      String? idIOM = remoteMessage.data['idnya'];
      String? idKoordinasi = remoteMessage.data['idnya'];
      String? idCompare = remoteMessage.data['idnya'];

      // Check the target value and navigate accordingly
      if (target == 'pbj') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => DetailPBJPage(
                noPermintaan: noPermintaan ?? "",
                isFromHistory: false,
              )),
        );
      }
      if (target == 'kasbon') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => KasbonDetailPage(
                noKasbon: noKasbon ?? "",
                idKasbon: idKasbon ?? "",
                isFromHistory: false,
              )),
        );
      }
      if (target == 'comparasion') {
        print("FCMCompare : $noCompare $idCompare");
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => DetailComparePage(
                noCompare: noCompare ?? "",
                idCompare: idCompare ?? "",
                isFromHistory: false,
              )),
        );
      }
      if (target == 'realisasi') {
        print("FCMRealisasi : $noCompare $idCompare");
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => RealisasiDetailPage(
                noRealisasi: noRealisasi ?? "",
                isFromHistory: false,
              )),
        );
      }

      if (target == 'iom') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => IomDetailPage(
                noIom: noIOM ?? "",
                idIom: idIOM ?? "",
                isFromHistory: false,
              )),
        );
      }

      if (target == 'kordinasi') {
        navigatorKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => IomDetailPage(
                noIom: noIOM ?? "",
                idIom: idIOM ?? "",
                idKoordinasi: idKoordinasi ?? "",
                isFromRekomendasi: true,
                isFromHistory: false,
              )),
        );
      }

      // Replace the current route with ProfilePage
      // navigatorKey.currentState!.pushReplacement(
      //   MaterialPageRoute(builder: (context) => ProfilePage()),
      // );
    });

    // If app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FCM Message data: ${message.data}");
      if (message.notification != null) {
        print("FCM Message notification: ${message.notification}");
        print("FCM Message notification: ${message.sentTime}");
      }
    });
  }

  // Save the device token into SharedPreferences
  Future<void> saveTokenToDevice(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceToken', token);
  }

  // Get the device token to use for push notification
  Future<String> getDeviceToken() async {
    // Request user permission for push notification
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

    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return deviceToken ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: Color(0xff030202),
      ), // Set your desired primary color here
    );

    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      theme: theme,
      navigatorKey: navigatorKey,
      // Set the global navigator key
      home: const ModernlandInitialPage(),
    );
  }
}
