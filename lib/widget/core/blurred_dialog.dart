import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurredDialog extends StatelessWidget {
  final String loadingText;

  const BlurredDialog({Key? key, required this.loadingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CupertinoAlertDialog(
              title: Text('Loading'),
              content: Column(
                children: [
                  SizedBox(height: 20,),
                  CupertinoActivityIndicator(),
                  SizedBox(height: 8),
                  Text(loadingText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}