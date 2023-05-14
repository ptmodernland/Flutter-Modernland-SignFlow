import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_ui_model.dart';
import 'package:flutter/material.dart';


class TipsAndTrickWidget extends StatelessWidget {
  const TipsAndTrickWidget({Key? key, required this.uimodel})
      : super(key: key);
  final TipsAndTrickUIModel uimodel;

  @override
  Widget build(BuildContext context) {

    var cardHeight = 75.0;

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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.asset(
                  uimodel.photoAsset, // Replace with your image URL
                  width: cardHeight,
                  height: cardHeight,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: cardHeight,
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
                      Text(
                        uimodel.description,
                        style: MyTheme.myStyleSecondaryTextStyle.copyWith(),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      iconSize: 18,
                      color: Colors.grey[200],
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: (){

                      },
                    ) ,
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
