import 'package:flutter/material.dart';

class ShareholderTransactionWidget extends StatelessWidget {
  final String userProfile;
  final String userName;
  final String comment;
  final String postingDate;
  final String bottomText;
  final bool isBuying;

  const ShareholderTransactionWidget(
      {Key? key,
      this.userProfile =
          "http://feylabs.my.id/fm/mdln_asset/mdln_circle_placeholder.png",
      this.comment = "Apa Kabar Gaes",
      this.postingDate = "4 December 2022",
      this.userName = "Yessy Permatasari",
      this.isBuying = true,
      this.bottomText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var baseURLImage = "http://feylabs.my.id/fm/mdln_asset/shareholder/";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("$baseURLImage$userName.png"),
                  radius: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      postingDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              comment,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              bottomText,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
