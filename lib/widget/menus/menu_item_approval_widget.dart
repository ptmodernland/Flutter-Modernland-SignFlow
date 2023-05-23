import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemApprovalWidget extends StatelessWidget {
  const MenuItemApprovalWidget(
      {Key? key,
      this.titleLeft = "Menunggu Approval",
      this.titleRight = "History Approval",
      this.unreadBadgeCount = "",
      this.onLeftTapFunction = null,
      this.onRightTapFunction = null})
      : super(key: key);

  final String titleLeft;
  final String titleRight;
  final String unreadBadgeCount;

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
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFEEEEE),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                            "http://feylabs.my.id/fm/mdln_asset/folder_icon_red.png"),
                        SizedBox(height: 10.0),
                        Text(
                          this.titleLeft,
                          style: GoogleFonts.lato()
                              .copyWith(color: Color(0xffAC4040), fontSize: 19),
                        ),
                      ],
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
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffEEF7FE),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                            "http://feylabs.my.id/fm/mdln_asset/folder_icon_blue.png"),
                        SizedBox(height: 10.0),
                        Text(
                          this.titleRight,
                          style: GoogleFonts.lato()
                              .copyWith(color: Color(0xff415EB6), fontSize: 19),
                        ),
                      ],
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
}
