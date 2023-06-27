import 'package:modernland_signflow/util/my_theme.dart';
import 'package:modernland_signflow/widget/stream/stream_ui_model.dart';
import 'package:flutter/material.dart';

class StreamHorizontalCard extends StatelessWidget {
  final StreamUIModel streamUiModel;

  const StreamHorizontalCard({super.key, required this.streamUiModel});

  @override
  Widget build(BuildContext context) {
    var cardHeight = 150.0;
    var photoHeight = 120.0;

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  streamUiModel.photoUrl,
                  height: photoHeight,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: photoHeight,
                      color: Colors.grey, // Placeholder color or image
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                this.streamUiModel.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: MyTheme.myStylePrimaryTextStyle.copyWith(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                this.streamUiModel.bottomText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: MyTheme.myStylePrimaryTextStyle.copyWith(fontSize: 12),
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    return Column(
      children: [
        Image.network(
          streamUiModel.photoUrl,
          // width: photoWidth,
          height: photoHeight,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              // width: photoWidth,
              height: photoHeight,
              color: Colors.grey, // Placeholder color or image
              child: Icon(
                Icons.error,
                color: Colors.white,
              ),
            );
          },
        )
      ],
    );

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
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
                  // width: photoWidth,
                  height: photoHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      // width: photoWidth,
                      height: photoHeight,
                      color: Colors.grey, // Placeholder color or image
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    );
                  },
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
        ],
      ),
    );
  }
}
