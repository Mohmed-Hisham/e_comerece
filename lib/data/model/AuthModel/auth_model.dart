class AuthModel {
  AuthModel({
    required this.success,
    required this.message,
    required this.authData,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final AuthData? authData;
  final dynamic errors;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json["success"],
      message: json["message"],
      authData: json["data"] is Map ? AuthData.fromJson(json["data"]) : null,
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": authData?.toJson(),
    "errors": errors,
  };
}

class AuthData {
  AuthData({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.token,
    this.code,
    this.newPassword,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? token;
  final String? code;
  final String? newPassword;

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      token: json["accessToken"],
      code: json["code"],
      newPassword: json["newPassword"],
    );
  }

  Map<String, dynamic> toJson() => {
    if (name != null) "name": name,
    if (email != null) "email": email,
    if (phone != null) "phone": phone,
    if (token != null) "accessToken": token,
    if (password != null) "password": password,
    if (code != null) "code": code,
    if (newPassword != null) "newPassword": newPassword,
  };
}
