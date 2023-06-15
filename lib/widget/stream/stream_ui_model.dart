class StreamUIModel {
  String name = "";
  int id = -99;
  String photoUrl = "";
  String photoAsset = "";
  String webUrl = "";
  String description = "";
  bool isFavorited = false;
  String bottomText = "";

  StreamUIModel(
      {this.name = "",
      this.id = -99,
      this.photoUrl = "",
      this.webUrl = '',
      this.description = "",
      this.bottomText = "",
      this.photoAsset = "",
      this.isFavorited = false});
}
