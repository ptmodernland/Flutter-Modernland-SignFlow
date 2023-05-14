
class RecommendedSpaceUIModel {
  int id = -99;
  String name = "";
  String photoUrl = "";
  String photoAsset = "";
  String webUrl = "";
  String description = "";
  String price = "";
  String city = "";
  String country = "";
  double rating = 5.0;
  String location = "Modernland";

  RecommendedSpaceUIModel(
      {this.id = -99,
      this.name = "",
      this.photoUrl = "",
      this.photoAsset = "asset/img/dummy/city_3.png",
      this.webUrl = '',
      this.description = '',
      this.price = "400k",
      this.city = "",
      this.country = "",
      this.rating = 4.4,
      this.location = "Modernland"});
}
