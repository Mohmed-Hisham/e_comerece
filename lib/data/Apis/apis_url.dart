class ApisUrl {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1';
  static const String sginup = '$_baseUrl/Auth/register';
  static const String loginStepOne = '$_baseUrl/Auth/login-step-one';
  static const String loginStepTwo = '$_baseUrl/Auth/login-step-two';
  static const String forgetPassword = '$_baseUrl/Auth/forgot-password';
  static const String verifyCode = '$_baseUrl/Auth/verify-code';
  static const String resetPassword = '$_baseUrl/Auth/reset-password';

  //                               Favorit
  static const String addFavorite = '$_baseUrl/Favorite/Add';
  static String getUserFavorites({String? platform}) =>
      '$_baseUrl/Favorite/GetUserFavorites?favorite_platform=${platform ?? ""}';
  static String favoritDelete(String id) => '$_baseUrl/Favorite/Remove/$id';

  //                               Address
  static const String addAddress = '$_baseUrl/Address/CreateAddress';
  static String updateAddress(String id) =>
      '$_baseUrl/Address/UpdateAddress/$id';
  static String deleteAddress(String id) =>
      '$_baseUrl/Address/DeleteAddress/$id';
  static const String getAddresses = '$_baseUrl/Address/GetAddresses';
}
