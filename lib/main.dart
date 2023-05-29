import 'package:bwa_cozy/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData.from(
      colorScheme: const ColorScheme.light(
          primary: Color(0xff030202)), // Set your desired primary color here
    );

    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SplashScreenPage(),
    );
  }
}
