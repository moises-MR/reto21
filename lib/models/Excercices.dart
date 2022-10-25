class ExercicesModel {
  String? title;
  String? description;
  double? duration;
  String? animation_normal;
  String? animation_bg;
  String? video;

  ExercicesModel(this.title, this.animation_bg, this.animation_normal,
      this.description, this.duration, this.video);
  ExercicesModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    duration = json["duration"];
    animation_normal = json["animation_normal"];
    animation_bg = json["animation_bg"];
    video = json["video"];
  }
}
