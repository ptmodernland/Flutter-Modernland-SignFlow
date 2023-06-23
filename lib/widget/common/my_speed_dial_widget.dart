import 'package:bwa_cozy/pages/approval/compare/compare_page.dart';
import 'package:bwa_cozy/pages/approval/iom/iom_page.dart';
import 'package:bwa_cozy/pages/approval/kasbon/kasbon_page.dart';
import 'package:bwa_cozy/pages/approval/koordinasi/koordinasi_waiting_all_page.dart';
import 'package:bwa_cozy/pages/approval/pbj/pbj_page.dart';
import 'package:bwa_cozy/pages/approval/realisasi/realisasi_page.dart';
import 'package:bwa_cozy/pages/container_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class mySpeedDialWidget extends StatelessWidget {
  const mySpeedDialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          child: Icon(CupertinoIcons.home),
          label: 'Home',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.square_list_fill),
          label: 'Inter Office Memo',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApprovalIomMainPage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.shuffle_thick),
          label: 'Koordinasi',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KoordinasiWaitingAllPage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.cart_fill_badge_plus),
          label: 'Pengadaan Barang Jasa',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApprovalPBJMainPage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.checkmark_seal_fill),
          label: 'Comparison',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApprovalCompareMainPage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.creditcard_fill),
          label: 'Kasbon',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApprovalKasbonMainPage()),
            );
          },
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.money_dollar_circle_fill),
          label: 'Realisasi',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerHomePage()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ApprovalRealisasiMainPage()),
            );
          },
        ),
      ],
    );
  }
}
