import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/stream/stream_ui_model.dart';
import 'package:flutter/material.dart';

class StreamCard extends StatelessWidget {
  final StreamUIModel streamUiModel;

  const StreamCard({super.key, required this.streamUiModel});

  @override
  Widget build(BuildContext context) {
    var cardWidth = 250.0;
    var cardHeight = 150.0;

    var photoWidth = cardWidth;
    var photoHeight = 120.0;

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
      width: cardWidth,
      height: cardHeight,
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
                child: Image.network(
                  streamUiModel.photoUrl,
                  width: photoWidth,
                  height: photoHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              this.streamUiModel.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: MyTheme.myStylePrimaryTextStyle.copyWith(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              this.streamUiModel.description,
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
