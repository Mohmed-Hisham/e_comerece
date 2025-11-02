class CategoriesAmazonModel {
  CategoriesAmazonModel({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  final String? status;
  final String? requestId;
  final Parameters? parameters;
  final List<Datum> data;

  factory CategoriesAmazonModel.fromJson(Map<String, dynamic> json) {
    return CategoriesAmazonModel(
      status: json["status"],
      requestId: json["request_id"],
      parameters: json["parameters"] == null
          ? null
          : Parameters.fromJson(json["parameters"]),
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({required this.name, required this.id});

  final String? name;
  final String? id;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(name: json["name"], id: json["id"]);
  }
}

class Parameters {
  Parameters({required this.country});

  final String? country;

  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(country: json["country"]);
  }
}
