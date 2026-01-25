class LegalModel {
  LegalModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
  });

  final bool? success;
  final String? message;
  final List<LegalData> data;
  final dynamic errors;

  factory LegalModel.fromJson(Map<String, dynamic> json) {
    return LegalModel(
      success: json["Success"] ?? json["success"],
      message: json["Message"] ?? json["message"],
      data: json["Data"] != null
          ? List<LegalData>.from(json["Data"].map((x) => LegalData.fromJson(x)))
          : (json["data"] != null
                ? List<LegalData>.from(
                    json["data"].map((x) => LegalData.fromJson(x)),
                  )
                : []),
      errors: json["Errors"] ?? json["errors"],
    );
  }
}

class LegalData {
  LegalData({this.id, this.key, this.title, this.content, this.updatedAt});

  final String? id;
  final String? key;
  final String? title;
  final String? content;
  final String? updatedAt;

  factory LegalData.fromJson(Map<String, dynamic> json) {
    return LegalData(
      id: json["Id"] ?? json["id"],
      key: json["Key"] ?? json["key"],
      title: json["Title"] ?? json["title"],
      content: json["Content"] ?? json["content"],
      updatedAt: json["UpdatedAt"] ?? json["updatedAt"],
    );
  }
}
