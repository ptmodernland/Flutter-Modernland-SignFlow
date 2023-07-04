import 'package:modernland_signflow/pages/common/webview_page.dart';
import 'package:modernland_signflow/util/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:modernland_signflow/repos/broadcast_message/dto/broadcast_message_response_dto.dart';

class BroadcastMessageWidget extends StatefulWidget {
  final BroadcastMessageResponseDto announcement;

  const BroadcastMessageWidget({required this.announcement});

  @override
  State<BroadcastMessageWidget> createState() => _BroadcastMessageWidgetState();
}

class _BroadcastMessageWidgetState extends State<BroadcastMessageWidget> {
  @override
  Widget build(BuildContext context) {
    var firstAnnouncement = widget.announcement.announcements?.first;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CommonWebviewPage(
              url: firstAnnouncement?.directLink ?? "",
            );
          }),
        );
      },
      child: Card(
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
                    Text(
                      'Broadcast Message',
                      style: MyTheme.myStylePrimaryTextStyle,
                    ),
                    Text(
                      firstAnnouncement?.messageText ?? "",
                      style: MyTheme.myStyleSecondaryTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${firstAnnouncement?.sentTimestamp ?? ""}\n${firstAnnouncement?.department}',
                      style: MyTheme.myStylePrimaryTextStyle
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
