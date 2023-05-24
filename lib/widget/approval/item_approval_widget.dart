import 'package:bwa_cozy/util/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemApprovalWidget extends StatelessWidget {
  final bool
      isApproved; // Add a boolean property to determine the approval status
  final itemCode;
  final date;
  final departmentTitle;
  final personName;
  final personImage;

  const ItemApprovalWidget(
      {Key? key,
      this.isApproved = false,
      this.itemCode = "",
      this.date = "",
      this.departmentTitle = "",
      this.personName = "",
      this.personImage = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? uiImage = Container();
    Widget? uiImagePersonNameSeparator = Container();
    Widget? uiPersonName = Container();
    Widget dateText = generateDateText(date);

    if (personImage != "") {
      uiImage = CircleAvatar(
        radius: 10.0,
        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        backgroundColor: Colors.transparent,
      );
    }

    if (personName != "") {
      uiPersonName = Text(
        personName,
        style: MyTheme.myStylePrimaryTextStyle.copyWith(
          fontSize: 12,
        ),
      );
    }

    if (personImage != "" && personName != "") {
      uiImagePersonNameSeparator = SizedBox(
        height: 20,
      );
    }

    Color statusColor = isApproved
        ? Colors.green
        : Color(0xFFFF7A7B); // Define color based on approval status

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: statusColor,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -5,
            // Position the container at the left edge
            top: 20,
            // Align it with the top of the second container
            bottom: 20,
            // Stretch it to match the height of the second container
            child: Container(
              key: Key("okee"),
              width: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(99)),
                  color: statusColor, // Use the defined color
                ),
                padding: EdgeInsets.only(top: 20, bottom: 20),
                height: 110,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              // Align content to the end
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, top: 10, right: 5.0, bottom: 10),
                  child: Row(
                    children: [
                      uiImage,
                      uiImagePersonNameSeparator,
                      uiPersonName
                    ],
                  ),
                ),
                Text(
                  departmentTitle,
                  style: MyTheme.myStylePrimaryTextStyle
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text(
                  itemCode,
                  style: MyTheme.myStylePrimaryTextStyle.copyWith(fontSize: 12),
                ),
                dateText,
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: statusColor, // Use the defined color
                    ),
                    child: Text(
                      isApproved ? "Approved" : "Waiting for Approval",
                      // Update text based on approval status
                      style: MyTheme.myStyleSecondaryTextStyle
                          .copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generateDateText(date) {
    try {
      DateTime currentDate = DateTime.now();
      DateTime providedDate = DateFormat("dd-MMMM-yyyy").parse(date);

      Duration difference = providedDate.difference(currentDate).abs();
      bool isMoreThan5Days = difference.inDays.abs() > 5;

      String text = "";

      if (difference.inDays.abs() >= 30) {
        int months = difference.inDays ~/ 30;
        text = 'Dikirim $months bulan yang lalu';
      } else if (difference.inDays.abs() < 30) {
        text = 'Dikirim ${difference.inDays} hari yang lalu';
      } else if (difference.inHours.abs() < 20) {
        int hours = difference.inHours;
        int minutes = difference.inMinutes.remainder(60);
        text = 'Dikirim $hours jam $minutes menit yang lalu';
      } else {
        int minutes = difference.inDays.abs();
        text = 'Dikirim pada $date';
      }
      return Text(text,
          style:
              MyTheme.myStylePrimaryTextStyle.copyWith(fontSize: 10).copyWith(
                    color: isMoreThan5Days ? Colors.red : Colors.black,
                  ));
    } catch (e) {
      print("error gan tanggal : " + e.toString());
      return Text(date,
          style: MyTheme.myStylePrimaryTextStyle
              .copyWith(fontSize: 10)
              .copyWith());
    }
  }
}
