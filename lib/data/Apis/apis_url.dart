class ApisUrl {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1';
  static const String getSignature = '$_baseUrl/Supabase/GetSignature';

  static const String sginup = '$_baseUrl/Auth/register';
  static const String loginStepOne = '$_baseUrl/Auth/login-step-one';
  static const String loginStepTwo = '$_baseUrl/Auth/login-step-two';
  static const String forgetPassword = '$_baseUrl/Auth/forgot-password';
  static const String verifyCode = '$_baseUrl/Auth/verify-code';
  static const String resetPassword = '$_baseUrl/Auth/reset-password';
  static const String updateUser = '$_baseUrl/Auth/update-user';
  static const String confirmPhoneVerification =
      '$_baseUrl/Auth/confirm-phone-verification';
  static const String googleLogin = '$_baseUrl/Auth/google-login';

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

  //                               Cart
  static const String addCart = '$_baseUrl/Cart/Add';
  static const String getUserCart = '$_baseUrl/Cart/GetUserCart';
  static const String getQuantity = '$_baseUrl/Cart/GetQuantity';
  static const String increaseQuantity = '$_baseUrl/Cart/IncreaseQuantity';
  static const String decreaseQuantity = '$_baseUrl/Cart/DecreaseQuantity';
  static String removeCart(String id) => '$_baseUrl/Cart/Remove/$id';

  //                               Coupon
  static String getCoupon(String code) =>
      '$_baseUrl/Coupon/GetCoupon?code=$code';
  static const String useCoupon = '$_baseUrl/Coupon/UseCoupon';

  //                               Local Service
  static String getLocalService({required int page, required int pageSize}) =>
      '$_baseUrl/LocalService/GetServices?page=$page&pageSize=$pageSize';
  static String searchLocalService(String search) =>
      '$_baseUrl/LocalService/Search?search=$search';
  static String getLocalServiceById(String id) =>
      '$_baseUrl/LocalService/GetService/$id';
  static const String addServiceRequest = '$_baseUrl/LocalService/AddRequest';

  static String getServiceRequestDetails(String id) =>
      '$_baseUrl/LocalService/GetRequestDetailsById/$id';
  static String getServiceRequests({
    String? status,
    required int page,
    required int pageSize,
  }) {
    String url =
        '$_baseUrl/LocalService/GetServiceRequests?pageNumber=$page&pageSize=$pageSize';
    if (status != null) {
      url += '&status=$status';
    }
    return url;
  }

  //                        Order

  static String getOrdersByUser(String status, int page, int pageSize) =>
      '$_baseUrl/Order/GetUserOrders?status=$status&pageNumber=$page&pageSize=$pageSize';
  static const String createOrder = '$_baseUrl/Order/Create';
  static String orderDetails(String id) =>
      '$_baseUrl/Order/GetOrderDetails/$id';
  static String cancelOrder(String orderId) =>
      '$_baseUrl/Order/CancelOrder/$orderId';

  //                         GetCheckOutReviewFee
  static const String getCheckOutReviewFee =
      '$_baseUrl/Checking/GetCheckOutReviewFee';

  //                         Slider
  static String getSlider({String? platform}) =>
      platform != null && platform.isNotEmpty
      ? '$_baseUrl/ImageSlider?platform=$platform'
      : '$_baseUrl/ImageSlider';

  //                           Currency
  static const String getCurrency = '$_baseUrl/Currency/GetRates';

  //                           AboutUs
  static const String getAboutUs = '$_baseUrl/AboutUs';

  //                           Chat
  static const String chatHub =
      'https://sltukapis-production.up.railway.app/chatHub';
  static const String createChat = '$_baseUrl/Chat/create';
  static const String myChats = '$_baseUrl/Chat/my-chats';
  static String getChatMessages(String chatId) =>
      '$_baseUrl/Chat/$chatId/messages';
  static String closeChat(String chatId) => '$_baseUrl/Chat/$chatId/close';

  //                           Legal
  static const String getLegal = '$_baseUrl/Legal/GetAll';
  static String getLegalByKey(String key) => '$_baseUrl/Legal/$key';
}
