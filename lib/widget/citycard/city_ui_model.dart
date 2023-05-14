class CityUIModel {
  String name = "";
  int id = -99;
  String photoUrl = "";
  String photoAsset = "";
  String webUrl = "";
  String description = "";
  bool isFavorited = false;

  CityUIModel(
      {this.name = "",
      this.id = -99,
      this.photoUrl = "",
      this.webUrl = '',
      this.description = "",
      this.photoAsset = "",
      this.isFavorited = false});
}
