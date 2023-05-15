import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:bwa_cozy/pages/splash/splash_screen.dart';

import 'package:flutter/material.dart';

import 'package:bwa_cozy/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class ContainerHomePage extends StatefulWidget {
  const ContainerHomePage({Key? key}) : super(key: key);

  @override
  _ContainerHomePageState createState() => _ContainerHomePageState();
}

class _ContainerHomePageState extends State<ContainerHomePage> {
  int _selectedTab = 0;

  List<Widget> _pages = [
    Center(
      child: HomePage(),
    ),
    Center(
      child: SplashScreenPage(),
    ),
    Center(
      child: Text("Products"),
    ),
    Center(
      child: Text("Contact"),
    ),
    Center(
      child: Text("Settings"),
    ),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: _pages[_selectedTab],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedTab,
      onTap: _changeTab,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              Icon(Icons.notifications),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    "5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "About"),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_3x3_outlined), label: "Product"),
        BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail), label: "Contact"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}