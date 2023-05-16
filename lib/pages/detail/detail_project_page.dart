import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/widget/facility_item/facility_item_widget.dart';
import 'package:bwa_cozy/widget/rating_star/show_rating_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProjectPage extends StatelessWidget {
  const DetailProjectPage({Key? key, required this.projectId})
      : super(key: key);

  final int projectId;

  @override
  Widget build(BuildContext context) {
    launchUrl(String url) async {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        throw (url);
      }
    }

    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Image.asset(
                "asset/img/dummy/detail_project_placeholder.png",
                width: MediaQuery.of(context).size.width,
                height: 328,
                fit: BoxFit.cover,
              ),

              ListView(
                children: [
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cluster Gajah Mada",
                                    style: MyTheme.myStylePrimaryTextStyle
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "200",
                                          style: MyTheme.myStyleSecondaryTextStyle
                                              .copyWith(color: Colors.deepPurple),
                                        ),
                                        TextSpan(
                                          text: " / month",
                                          style: MyTheme.myStyleSecondaryTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ShowRatingWidget(
                                    rating: 4.5,
                                    maxRating: 5,
                                    shapeSize: 14.0,
                                    shapeColor: Colors.blue,
                                    emptyShapeColor: Colors.grey,
                                    ratingShape: ShowRatingShape.circle,
                                  ),
                                ],
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    "asset/img/icons/logo_modernland.png",
                                    height: 35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Main Facilities",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                FacilityItemWidget(
                                  name: "Bedroom",
                                  count: 3,
                                  imageUrl: "asset/img/dummy/icon_bedroom.png",
                                ),
                                FacilityItemWidget(
                                  name: "Kitchen",
                                  count: 3,
                                  imageUrl: "asset/img/dummy/icon_kitchen.png",
                                ),
                                FacilityItemWidget(
                                  name: "Cupboard",
                                  count: 3,
                                  imageUrl: "asset/img/dummy/icon_cupboard.png",
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Photo",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "asset/img/dummy/foto_3.png",
                                    width: 110,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "asset/img/dummy/foto_3.png",
                                    width: 110,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "asset/img/dummy/foto_3.png",
                                    width: 110,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Location",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Location",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),   Text(
                            "Location",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Location",
                            textAlign: TextAlign.start,
                            style: MyTheme.myStylePrimaryTextStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl("https://goo.gl/maps/GsyE9oLH9yu9bH4Q6");
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Novotel Gajah Mada Hotel Jl. Gajah Mada No. XX Jakarta Pusat, Indonesia",
                                    textAlign: TextAlign.start,
                                    style:
                                    MyTheme.myStyleSecondaryTextStyle.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 25.0,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 24.0,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          //Lupa Password Button
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  launchUrl("tel://+6282113530950");
                                },
                                style: ButtonStyle(
                                  iconColor:
                                  MaterialStatePropertyAll<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                                icon: Transform.rotate(
                                    angle: 320 * (3.1415926535897932 / 180),
                                    child: const Icon(Icons.send)),
                                label: const Text(
                                  "Lihat Website",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {},
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        CupertinoIcons.heart,
                        size: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CupertinoButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () {},
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                        size: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
