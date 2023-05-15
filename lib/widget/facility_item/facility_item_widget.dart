import 'package:bwa_cozy/util/my_theme.dart';
import 'package:flutter/material.dart';

class FacilityItemWidget extends StatelessWidget {
  const FacilityItemWidget({
    Key? key,
    this.name = "Garden",
    this.count = 4,
    this.imageUrl = "asset/img/dummy/icon_bedroom.png",
  }) : super(key: key);

  final String name;
  final int count;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            width: 52,
            height: 52,
          ),
          SizedBox(
            height: 8,
          ),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 12),
              children: [
                TextSpan(
                  text: this.count.toString(),
                  style: MyTheme.myStyleSecondaryTextStyle
                      .copyWith(color: Colors.deepPurple)
                      .copyWith(fontSize: 10),
                ),
                TextSpan(text:" "),
                TextSpan(
                  text: this.name,
                  style:
                      MyTheme.myStyleSecondaryTextStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
