import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modernland_signflow/pages/common/webview_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentDetailWidget extends StatelessWidget {
  DocumentDetailWidget(
      {super.key,
      this.title = "Nama Calon",
      this.content = "Yossy Gheasanta",
      this.icon = const Icon(CupertinoIcons.info_circle),
      this.fileURL = null,
      this.isForDownload = false});

  final String? fileURL;
  final String title;
  final String content;
  final Color color = Colors.black;
  final Icon icon;
  final bool isForDownload;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Icon(
            //   CupertinoIcons.info_circle, // Replace with the desired icon
            //   color: color,
            // ),
            SizedBox(width: 8), // Adjust the width as needed
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.lato().copyWith(
                    fontSize: 15, color: color, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            // Icon(
            //   CupertinoIcons.info_circle, // Replace with the desired icon
            //   color: Colors.transparent,
            // ),
            SizedBox(width: 8), // Adjust the width as needed
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (fileURL != null && fileURL!.startsWith('http')) {
                    if (this.isForDownload) {
                      if (this.fileURL != "-") {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text('Download File',
                                  style: TextStyle(
                                      // color: Colors.blue
                                      )),
                              content: Text(
                                  'This action will open your browser and downloading the file. Do you want to continue?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Cancel',
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Open Browser',
                                      style:
                                          TextStyle(color: Colors.blueAccent)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    var uri = this.splitUrl(fileURL ?? "");
                                    _launchInBrowser(uri);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {}
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CommonWebviewPage(
                          url: fileURL ?? "",
                        );
                      }));
                    }
                  }
                },
                child: Container(
                  child: Text(
                    content.isEmpty ? '-' : content,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 13,
                      color: fileURL != null && content.isNotEmpty
                          ? Colors
                              .blue // Set the color to a link color if it's a link
                          : Colors.black,
                      // Set a default color if it's not a link or null
                      fontWeight: FontWeight.w100,
                      decoration: fileURL != null && content.isNotEmpty
                          ? TextDecoration
                              .underline // Underline the text if it's a link
                          : TextDecoration
                              .none, // Remove decoration if it's not a link or null
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Uri splitUrl(String url) {
    return Uri.parse(url);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
