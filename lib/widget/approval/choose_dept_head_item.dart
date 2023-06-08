import 'package:flutter/material.dart';

class ChooseDeptHeadItem extends StatelessWidget {
  final String userProfile;
  final String userName;
  final String userEmail;
  final String userDepartment;
  final VoidCallback? onClick; // New parameter for onClick callback

  const ChooseDeptHeadItem({
    Key? key,
    required this.onClick, // Required onClick callback
    this.userProfile =
        "http://feylabs.my.id/fm/mdln_asset/mdln_circle_placeholder.png",
    this.userEmail = "@modernland.co.id",
    this.userName = "Yessy Permatasari",
    this.userDepartment = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick, // Assign onClick callback to onTap property
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userProfile),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
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
                        userDepartment,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
