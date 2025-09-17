class Appapi {
  static const String server = "http://192.168.1.13/ecommerce";
  // static const String server = "http://10.188.240.126/ecommerce";
  static const String test = "$server/test.php";

  //                         Auth

  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String loginStepOne = "$server/auth/login_ste_one.php";
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
  static const String viewFavoriteplaform =
      "$server/favorite/favorite_viwe_platform.php";

  // cart

  static const String addCart = "$server/cart/cart_add.php";
  static const String viweCart = "$server/cart/cart_viwe.php";
  static const String removcart = "$server/cart/cart_remove.php";
  static const String addPrise = "$server/cart/cart_add_preise.php";
  static const String removPrise = "$server/cart/cart_remove_prise.php";
  static const String cartquantity = "$server/cart/cart_quantity.php";

  //cloudinary
  static const String uploadPreset = 'ecommerce_unsigned';
  static const String cloudName = 'dgonvbimk';
}
