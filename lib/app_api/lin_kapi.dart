class Appapi {
  static const String server = "http://10.107.84.58/ecommerce";
  static const String test = "$server/test.php";

  //                         Auth

  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String verifycode = "$server/auth/verifycode.php";
  static const String resend = "$server/auth/resend.php";

  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String verifycodeResetPassword =
      "$server/forgetpassword/ferifycoderesetpassword.php";
  static const String resetPassword =
      "$server/forgetpassword/resetpassword.php";

  // fanorite

  static const String addFavorite = "$server/favorite/favorite_add.php";
  static const String viweFavorite = "$server/favorite/favorite_viwe.php";
  static const String removeFavorite = "$server/favorite/favorite_remove.php";

  // cart

  static const String addCart = "$server/cart/cart_add.php";
  static const String viweCart = "$server/cart/cart_viwe.php";
  static const String removcart = "$server/cart/cart_remove.php";
  static const String addPrise = "$server/cart/cart_add_preise.php";
  static const String removPrise = "$server/cart/cart_remove_prise.php";
}
