class AboutUsModel {
  AboutUsModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
  });

  final bool? success;
  final String? message;
  final List<AboutUsData> data;
  final dynamic errors;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<AboutUsData>.from(
              json["data"]!.map((x) => AboutUsData.fromJson(x)),
            ),
      errors: json["errors"],
    );
  }
}

class AboutUsData {
  AboutUsData({this.id, this.title, this.body, this.image});

  final String? id;
  final String? title;
  final String? body;
  final String? image;

  factory AboutUsData.fromJson(Map<String, dynamic> json) {
    return AboutUsData(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      image: json["image"],
    );
  }
}
