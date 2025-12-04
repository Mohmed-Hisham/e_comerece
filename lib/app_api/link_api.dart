class Appapi {
  static const String server =
      "https://ecommerce-api-production-9554.up.railway.app";
  // static const String server = "http://192.168.100.166/ecommerce";
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

  // Address
  static const String addAddress = "$server/addresses/add_address.php";
  static const String getAddress = "$server/addresses/get_address.php";
  static const String removeAddress = "$server/addresses/delete_address.php";
  static const String updateAddress = "$server/addresses/update_address.php";
  // Support
  static const String sendMessage = "$server/helper_user/send_message.php";
  static const String getChats = "$server/helper_user/get_chats.php";
  static const String getMasseges = "$server/helper_user/get_masseges.php";

  // cash server api
  static const String insertCash = "$server/api_cash/search_cash.php";
  static const String getCash = "$server/api_cash/get_search_cash.php";
  static const String deleteCash = "$server/api_cash/cleanup_expired.php";
  // coupons api
  static const String getCoupons = "$server/coupons/get_coupon.php";
  static const String useCoupon = "$server/coupons/use_coupon.php";

  // orders
  static const String addOrder = "$server/orders/creat_order.php";
  static const String getOrder = "$server/orders/get_orders.php";
  static const String cancelOrder = "$server/orders/cancel_order.php";
  // static const String addOrderDetails = "$server/orders/add_order_details.php";

  // local Service
  static const String getlocalService = "$server/local_services/view.php";
  static const String searchlocalService = "$server/local_services/search.php";
  static const String addlocalService =
      "$server/local_services/service_request/add.php";
  static const String addOrderlocalService =
      "$server/local_services/order/add.php";
  static const String getOrderlocalService =
      "$server/local_services/order/view.php";
  static const String cancelOrderlocalService =
      "$server/local_services/order/action.php";
  static const String getDetailsOrderLocalService =
      "$server/local_services/order/details.php";
  static const String imageLocalService = "$server/upload/local_services";

  //cloudinary
  static const String uploadPreset = 'ecommerce_unsigned';
  static const String cloudName = 'dgonvbimk';
}
