import 'package:flutter/material.dart';
import 'package:modernland_signflow/pages/splash/splash_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SplashScreenPage()),
                (route) => false,
          );
        }, child: Text("Logout")),
      ),
    );
  }
}
