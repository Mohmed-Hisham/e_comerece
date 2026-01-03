class ApisUrl {
  static const String baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1';
  static const String sginup = '$baseUrl/Auth/register';
  static const String loginStepOne = '$baseUrl/Auth/login-step-one';
  static const String loginStepTwo = '$baseUrl/Auth/login-step-two';
  static const String forgetPassword = '$baseUrl/Auth/forgot-password';
  static const String verifyCode = '$baseUrl/Auth/verify-code';
  static const String resetPassword = '$baseUrl/Auth/reset-password';
}
