class UserProfileResponse {
  final bool? success;
  final String? message;
  final UserProfileData? data;
  final dynamic errors;

  UserProfileResponse({this.success, this.message, this.data, this.errors});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] is Map ? UserProfileData.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class UserProfileData {
  final String? name;
  final String? phone;

  UserProfileData({this.name, this.phone});

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(name: json['name'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (phone != null) 'phone': phone,
  };
}
