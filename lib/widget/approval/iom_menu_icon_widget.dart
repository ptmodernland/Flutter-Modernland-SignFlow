import 'package:flutter/material.dart';

class IomMenuIconWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final int badgeCount;

  const IomMenuIconWidget({
    Key? key,
    required this.iconData,
    required this.label,
    required this.badgeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final deviceWidth = screenSize.width;
    final deviceHeight = screenSize.height;

    double avatarRadius;

    if (deviceWidth <= 600 && deviceHeight <= 800) {
      // For small devices like phones
      avatarRadius = deviceWidth * 0.09;
    } else if (deviceWidth <= 1200 && deviceHeight <= 1200) {
      // For medium-sized devices like tablets
      avatarRadius = deviceWidth * 0.08;
    } else {
      // For larger devices like iPads
      avatarRadius = deviceWidth * 0.06;
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: Icon(
                  iconData,
                  size: avatarRadius * 0.8,
                  color: Colors.black,
                ),
              ),
            ),
            if (badgeCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: avatarRadius * 2.2,
          // Adjust the width based on the avatarRadius
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}