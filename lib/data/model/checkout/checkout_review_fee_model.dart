class CheckoutReviewFeeModel {
  CheckoutReviewFeeModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final CheckoutReviewFeeData? data;
  final dynamic errors;

  factory CheckoutReviewFeeModel.fromJson(Map<String, dynamic> json) {
    return CheckoutReviewFeeModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : CheckoutReviewFeeData.fromJson(json["data"]),
      errors: json["errors"],
    );
  }
}

class CheckoutReviewFeeData {
  CheckoutReviewFeeData({
    required this.key,
    required this.name,
    required this.value,
    required this.description,
  });

  final String? key;
  final String? name;
  final double? value;
  final String? description;

  factory CheckoutReviewFeeData.fromJson(Map<String, dynamic> json) {
    return CheckoutReviewFeeData(
      key: json["key"],
      name: json["name"],
      value: (json["value"] as num?)?.toDouble(),
      description: json["description"],
    );
  }
}
