import 'package:google_sign_in/google_sign_in.dart';

/// Helper لتسجيل الدخول بـ Google
class GoogleSignInHelper {
  /// تسجيل الدخول بـ Google والحصول على ID Token
  static Future<String?> signIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    return googleAuth?.idToken;
  }
}
