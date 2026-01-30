import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<String?> signIn() async {
    await _googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    return googleAuth?.idToken;
  }
}
