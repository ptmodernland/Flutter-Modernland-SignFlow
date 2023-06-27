import 'package:modernland_signflow/util/my_theme.dart';
import 'package:flutter/material.dart';

class BroadcastMessageWidget extends StatefulWidget {
  @override
  _BroadcastMessageWidgetState createState() => _BroadcastMessageWidgetState();
}

class _BroadcastMessageWidgetState extends State<BroadcastMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "asset/img/icons/logo_modernland.png",
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: 50,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Broadcast Message',
                      style: MyTheme.myStylePrimaryTextStyle),
                  Text(
                      'Pengumuman Update Aplikasi ke Versi 2.43, agar melakukan pengunduhan ke versi terbaru di Playstore/Appstore',
                      style: MyTheme.myStyleSecondaryTextStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text('14 Juni 2023, 08:08:22 - Modernland Realty Tbk IT Team',
                      style: MyTheme.myStylePrimaryTextStyle
                          .copyWith(fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
