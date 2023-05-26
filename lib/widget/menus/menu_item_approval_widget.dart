import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemApprovalWidget extends StatelessWidget {
  const MenuItemApprovalWidget({
    Key? key,
    this.titleLeft = "Menunggu\nApproval",
    this.titleRight = "History\nApproval",
    this.unreadBadgeCount = "",
    this.showIcon = false,
    this.colorScheme = 1,
    this.onLeftTapFunction,
    this.onRightTapFunction,
  }) : super(key: key);

  final String titleLeft;
  final String titleRight;
  final int colorScheme;
  final String unreadBadgeCount;
  final bool showIcon;
  final Function? onLeftTapFunction;
  final Function? onRightTapFunction;

  @override
  Widget build(BuildContext context) {
    BoxDecoration? badgeNotifDecoration = null;
    Widget textCount = Text("");

    if (this.unreadBadgeCount == "" || this.unreadBadgeCount == "0") {
      badgeNotifDecoration = null;
      print("badge PBJ is null");
    } else {
      textCount = Text(
        this.unreadBadgeCount, // Replace with your badge count
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
      badgeNotifDecoration = BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                onLeftTapFunction?.call();
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color:
                              buildColor(position: "left", isABackground: true),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showIcon)
                              Image.network(
                                "http://feylabs.my.id/fm/mdln_asset/folder_icon_red.png",
                              ),
                            SizedBox(height: 10.0),
                            Text(
                              this.titleLeft,
                              style: GoogleFonts.lato().copyWith(
                                  color: buildColor(
                                      position: "left", isABackground: false),
                                  fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: badgeNotifDecoration,
                      child: textCount,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                onRightTapFunction?.call();
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: buildColor(
                              position: "right", isABackground: true),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showIcon)
                              Image.network(
                                "http://feylabs.my.id/fm/mdln_asset/folder_icon_red.png",
                              ),
                            SizedBox(height: 10.0),
                            Text(
                              this.titleRight,
                              style: GoogleFonts.lato().copyWith(
                                  color: buildColor(
                                      position: "right", isABackground: false),
                                  fontSize: 19),
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
        ],
      ),
    );
  }

  Color buildColor({String position = "left", bool isABackground = false}) {
    if (colorScheme == 1) {
      if (position == "left") {
        if (isABackground) {
          return Color(0xffEEF7FE);
        } else {
          return Color(0xff415EB6);
        }
      }

      if (position == "right") {
        if (isABackground) {
          return Color(0xffFFFBEC);
        } else {
          return Color(0xffFFB110);
        }
      }
    }

    if (colorScheme == 2) {
      if (position == "left") {
        if (isABackground) {
          return Color(0xffFEEEEE);
        } else {
          return Color(0xffAC4040);
        }
      }

      if (position == "right") {
        if (isABackground) {
          return Color(0xffF0FFFF);
        } else {
          return Color(0xff23B0B0);
        }
      }
    }

    if (colorScheme == 3) {
      if (position == "left") {
        if (isABackground) {
          return Color(0xffEFFFEF);
        } else {
          return Color(0xff40CA3D);
        }
      }

      if (position == "right") {
        if (isABackground) {
          return Color(0xffF6EBFB);
        } else {
          return Color(0xff3F234F);
        }
      }
    }

    return Colors.black;
  }
}