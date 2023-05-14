import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/recommended_space/recommended_space_ui_model.dart';
import 'package:flutter/material.dart';

class RecommendedSpaceWidget extends StatelessWidget {
  const RecommendedSpaceWidget({Key? key, required this.uimodel})
      : super(key: key);
  final RecommendedSpaceUIModel uimodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.asset(
                    uimodel.photoAsset, // Replace with your image URL
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            uimodel.rating.toString(),
                            style: MyTheme.myStyleSecondaryTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          Image.asset("asset/img/dummy/icon_star.png"),
                        ],
                      )),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 100,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        uimodel.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTheme.myStylePrimaryTextStyle.copyWith(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: uimodel.price,
                              style: MyTheme.myStyleSecondaryTextStyle
                                  .copyWith(color: Colors.deepPurple),
                            ),
                            TextSpan(
                                text: " / month",
                                style: MyTheme.myStyleSecondaryTextStyle
                                    .copyWith())
                          ],
                        ),
                      ),
                      SizedBox(height: 7),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      uimodel.location,
                      style: MyTheme.myStyleSecondaryTextStyle.copyWith(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
