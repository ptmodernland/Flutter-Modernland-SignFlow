import 'package:bwa_cozy/pages/detail/detail_project_page.dart';
import 'package:bwa_cozy/pages/settings/settings_page.dart';
import 'package:bwa_cozy/util/my_colors.dart';
import 'package:bwa_cozy/util/my_theme.dart';
import 'package:bwa_cozy/util/resposiveness.dart';
import 'package:bwa_cozy/widget/citycard/city_card.dart';
import 'package:bwa_cozy/widget/citycard/city_ui_model.dart';
import 'package:bwa_cozy/widget/recommended_space/recommended_space_ui_model.dart';
import 'package:bwa_cozy/widget/recommended_space/recommended_space_widget.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_ui_model.dart';
import 'package:bwa_cozy/widget/tips_and_trick/tips_and_trick_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
          child: ListView(
            children: [
              SizedBox(
                height: 35,
              ),
              Image.asset(
                "asset/img/icons/logo_modernland.png",
                width: ScreenUtil.getScreenWidth(context) * 0.1,
                height: 50,
              ),
              Text(
                "Modernland Approval",
                style: MyTheme.myStylePrimaryTextStyle
                    .copyWith(fontSize: 20, fontWeight: MyTheme.bold),
              ),
              Text(
                "Modernland Approval revolutionizes the approval process, empowering efficient decision-making and expediting critical assessments.",
                style: MyTheme.myStyleSecondaryTextStyle.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Our Project",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  CityCard(
                      cityUIModel: CityUIModel(
                          name: "Modernland Cilejit",
                          photoAsset: "asset/img/dummy/city_2.png",
                          photoUrl:
                              "https://modernlandcilejit.co.id/storage/unit-galleries/November2022/gKj1J8zkWASd18RtmjKN.jpg")),
                  CityCard(
                    cityUIModel: CityUIModel(
                        name: "Jakarta Garden City",
                        photoAsset: "asset/img/dummy/city_1.png",
                        photoUrl:
                            "https://cdn1-production-images-kly.akamaized.net/ydV2Koug9Jv217NQ54C6H20cZ14=/1200x900/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/1723119/original/015408500_1506583938-AEON_MALL_JAKARTA_GARDEN__CITY.JPG",
                        description:
                            "Welcome to Jakarta Garden City, a captivating city that harmoniously combines nature and urban living. Situated in the heart of Jakarta, this sprawling city offers a serene and picturesque environment amidst the bustling metropolis. Residents of Jakarta Garden City enjoy lush parks, beautifully landscaped gardens, and a range of recreational amenities. The city is well-connected, with easy access to schools, hospitals, shopping centers, and entertainment options. Experience the best of both worlds in Jakarta Garden City, where tranquility and modern conveniences coexist."),
                  ),
                  CityCard(
                    cityUIModel: CityUIModel(
                        name: "Modernland Cikande",
                        photoAsset: "asset/img/dummy/city_3.png",
                        description:
                            "Modernland Cikande is a vibrant and dynamic city that sets the benchmark for modern living. Strategically located in Cikande, this city offers a comprehensive range of amenities, including residential complexes, commercial establishments, educational institutions, and recreational facilities. With its contemporary infrastructure and well-designed urban planning, Modernland Cikande provides a comfortable and convenient lifestyle for its residents. The city is known for its vibrant community, where residents can enjoy a thriving social life and a host of modern conveniences right at their doorstep.",
                        photoUrl:
                            "https://www.modernland.co.id/uploads/default/files/54250d2b06a2b2bd944ab460e101efa4.jpg"),
                  ),
                  CityCard(
                      cityUIModel: CityUIModel(
                    name: "Vakasa City",
                    photoAsset: "asset/img/dummy/city_1.png",
                    photoUrl:
                        "https://www.modernland.co.id/uploads/default/files/25b0f3abac4587b57d710d0e21579df2.jpg",
                    description:
                        "Discover Vakasa City, a city that embodies progress, innovation, and endless opportunities. This dynamic and evolving city is a hub for businesses, entrepreneurs, and ambitious individuals seeking growth and success. With its state-of-the-art infrastructure, world-class facilities, and strategic location, Vakasa City provides a fertile ground for economic development. The city offers a diverse range of industries, a vibrant cultural scene, and a strong entrepreneurial ecosystem. Whether you're looking to establish a thriving business or embrace a fulfilling lifestyle, Vakasa City is the place to be.",
                  )),
                  CityCard(
                    cityUIModel: CityUIModel(
                        name: "Novotel Gajah Mada",
                        photoAsset: "asset/img/dummy/city_3.png",
                        description:
                            "Indulge in luxury and sophistication at Novotel Gajah Mada, a premier hotel located in the heart of the city. With its elegant design, impeccable service, and top-notch amenities, Novotel Gajah Mada offers a truly remarkable experience for both business and leisure travelers. The hotel features luxurious accommodations, world-class dining options, well-equipped conference facilities, and a range of recreational amenities. Its strategic location provides easy access to major attractions, shopping districts, and cultural landmarks. Experience unparalleled comfort and hospitality at Novotel Gajah Mada, where every stay is a memorable one."),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recommended Spaces",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    RecommendedSpaceWidget(
                      uimodel: RecommendedSpaceUIModel(
                        name: "Cluster Yossy",
                        location: "Jakarta Garden City",
                      ),
                    ),
                    RecommendedSpaceWidget(
                      onCardTap: (id) {
                        // Handle the card tap event with the provided id
                        print('Tapped on card with ID: $id');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DetailProjectPage(
                              projectId: id,
                            );
                          }),
                        );
                        // Perform any other actions based on the id
                      },
                      uimodel: RecommendedSpaceUIModel(
                        name: "Gajah Mada Suit",
                        location: "Novotel Gajah Mada ",
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Tips and Trick",
                style: MyTheme.myStyleSecondaryTextStyle
                    .copyWith(fontSize: 20, color: AppColors.primaryColor2),
              ),
              Container(
                height: 275,
                margin: EdgeInsets.only(top: 20),
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    TipsAndTrickWidget(
                      uimodel: TipsAndTrickUIModel(
                          name: "Pedoman Aplikasi",
                          description: "Terakhir diupdate : 12 Mei 2022",
                          photoAsset: "asset/img/dummy/guideline_1.png"),
                    ),
                    TipsAndTrickWidget(
                      uimodel: TipsAndTrickUIModel(
                          name: "Pedoman Penggunaan",
                          description: "Terakhir diupdate : 12 Januari 2022",
                          photoAsset: "asset/img/dummy/guideline_2.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
