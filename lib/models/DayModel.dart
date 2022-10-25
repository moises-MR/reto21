class DayModel {
  int? day;
  String? title;
  String? pathJsonRoutine;
  String? subTitle;
  String? assetSvg1;
  String? assetSvg2;
  String? image;
  double? heightImage;
  String? subTitleDay;
  String? colorContainer;
  String? colorSvg;

  DayModel(
      this.day,
      this.assetSvg1,
      this.assetSvg2,
      this.heightImage,
      this.image,
      this.pathJsonRoutine,
      this.subTitle,
      this.subTitleDay,
      this.title,
      this.colorContainer,this.colorSvg);

  DayModel.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    title = json["title"];
    pathJsonRoutine = json["pathJsonRoutine"];
    subTitle = json["subTitle"];
    assetSvg1 = json["assetSvg1"];
    assetSvg2 = json["assetSvg2"];
    image = json["image"];
    heightImage = json["heightImage"];
    subTitleDay = json["subTitleDay"];
    colorContainer = json["colorContainer"];
    colorSvg = json["colorSvg"];
  }
}
