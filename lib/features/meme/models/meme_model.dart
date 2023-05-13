class MemeModel {
  String? id;

  String? upperText;
  String? lowerText;
  String? image;

  MemeModel({
    this.image,
    this.upperText,
    this.lowerText,
  });

  MemeModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    upperText = json['upper text'] ?? "";
    lowerText = json['lower text'] ?? "";
    id = json['id'].toString();
  }
}
