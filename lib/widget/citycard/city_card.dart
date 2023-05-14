import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/citycard/city_ui_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final CityUIModel cityUIModel;

  const CityCard({super.key, required this.cityUIModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.asset(
                  this.cityUIModel.photoAsset, // Replace with your image URL
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(20)),
                    child: Image.asset("asset/img/dummy/icon_star.png"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              this.cityUIModel.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: MyTheme.myStylePrimaryTextStyle.copyWith(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              this.cityUIModel.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: MyTheme.myStyleSecondaryTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
