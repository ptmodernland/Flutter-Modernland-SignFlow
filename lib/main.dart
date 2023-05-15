import 'package:bwa_cozy/pages/container_home.dart';
import 'package:bwa_cozy/pages/detail/detail_project_page.dart';
import 'package:bwa_cozy/pages/home/home_page.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailProjectPage(
        projectId: 3,
      ),
    );
  }
}
