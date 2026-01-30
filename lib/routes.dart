import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/middleware/middleware.dart';
import 'package:e_comerece/viwe/screen/Checkout/checkout_screen.dart';
import 'package:e_comerece/viwe/screen/Support/chats_screen.dart';
import 'package:e_comerece/viwe/screen/Support/messages_screen.dart';
import 'package:e_comerece/viwe/screen/alibaba/alibaba_by_image_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/home_alibaba_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_details_alibab_view.dart';
import 'package:e_comerece/viwe/screen/favorite/favorites_platforms.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_from_cat.dart';
import 'package:e_comerece/viwe/screen/aliexpress/search_by_image_view.dart';
import 'package:e_comerece/viwe/screen/amazon/amazon_home_view.dart';
import 'package:e_comerece/viwe/screen/amazon/product_details_amazon_view.dart';
import 'package:e_comerece/viwe/screen/amazon/product_from_cat_view.dart';
import 'package:e_comerece/viwe/screen/auth/forgetpassword/forgotpassword.dart';
import 'package:e_comerece/viwe/screen/auth/login.dart';
import 'package:e_comerece/viwe/screen/auth/verifycodesignup.dart';
import 'package:e_comerece/viwe/screen/auth/login_step_one.dart';
import 'package:e_comerece/viwe/screen/auth/forgetpassword/resetpassword.dart';
import 'package:e_comerece/viwe/screen/auth/sginup.dart';
import 'package:e_comerece/viwe/screen/auth/forgetpassword/successreset.dart';
import 'package:e_comerece/viwe/screen/auth/successssginup.dart';
import 'package:e_comerece/viwe/screen/auth/forgetpassword/veyfiycpde.dart';
import 'package:e_comerece/viwe/screen/aliexpress/home_aliexpriess.dart';
import 'package:e_comerece/viwe/screen/cart/cart_view.dart';
import 'package:e_comerece/viwe/screen/favorite/favorite_view.dart';
import 'package:e_comerece/viwe/screen/home/homenavbar.dart';
import 'package:e_comerece/viwe/screen/home/search_screen.dart';
import 'package:e_comerece/viwe/screen/settings/language.dart';
import 'package:e_comerece/viwe/screen/local_serviess/local_service_details_view.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/local_service_order_details_view.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/view_local_service_orders_screen.dart';
import 'package:e_comerece/viwe/screen/local_serviess/service_order_screen.dart';
import 'package:e_comerece/viwe/screen/maps/add_address.dart';
import 'package:e_comerece/viwe/screen/onboarding.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_details_view.dart';
import 'package:e_comerece/viwe/screen/shein/home_shein_view.dart';
import 'package:e_comerece/viwe/screen/shein/product_by_category.dart';
import 'package:e_comerece/viwe/screen/shein/product_details_shein_view.dart';
import 'package:e_comerece/viwe/screen/orders/order_details_screen.dart';
import 'package:e_comerece/viwe/screen/splashscreen/splashscreen.dart';
import 'package:e_comerece/viwe/screen/settings/legal_view.dart';
import 'package:e_comerece/viwe/screen/our_products/our_products_view.dart';
import 'package:e_comerece/viwe/screen/our_products/our_product_details_view.dart';
import 'package:e_comerece/viwe/screen/our_products/our_products_search_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

// ✅ تقليل مدة التنقل لتحسين الأداء
final int transitionDurations = 200;
final Transition transitionType = Transition.fadeIn;
List<GetPage<dynamic>>? routes = [
  // Onboarding
  GetPage(
    name: "/",
    page: () => const Splashscreen(),
    middlewares: [MyMiddleware()],
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  // GetPage(name: "/", page: () => const Onbording()),
  GetPage(
    name: AppRoutesname.onBoarding,
    page: () => const Onbording(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  //splash
  GetPage(
    name: AppRoutesname.splash,
    page: () => const Splashscreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.language,
    page: () => const MyLanguage(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Auth
  GetPage(
    name: AppRoutesname.loginStepOne,
    page: () => const LoginStepOne(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.login,
    page: () => const Login(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.sginin,
    page: () => const Sginup(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.forgetpassword,
    page: () => const Forgetpassword(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.verFiyCode,
    page: () => const Veryfiycode(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.verFiyCodeSignUp,
    page: () => const Verifycodesignup(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.resetPassWord,
    page: () => const Resetpassword(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.successReset,
    page: () => const Successreset(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.successsginup,
    page: () => const SuccessSignUpView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Home
  GetPage(
    name: AppRoutesname.homepage1,
    page: () => const HomePage1(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.homepage,
    page: () => const Homenavbar(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  // Main Tab Routes (with bottom bar)
  GetPage(
    name: AppRoutesname.cartTab,
    page: () => const Homenavbar(initialTab: 1),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.ordersTab,
    page: () => const Homenavbar(initialTab: 2),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.localServicesTab,
    page: () => const Homenavbar(initialTab: 3),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.settingsTab,
    page: () => const Homenavbar(initialTab: 4),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  // Search Screen
  GetPage(
    name: AppRoutesname.searchScreen,
    page: () => const SearchScreen(),
    transition: Transition.cupertino,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.detelspage,
    page: () => const ProductDetailsView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.shearchname,
    page: () => const ProductFromCat(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.favoritescreen,
    page: () => const FavoriteScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.cartscreen,
    page: () => const CartView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  //Aliexpress
  GetPage(
    name: AppRoutesname.favoritealiexpress,
    page: () => const FavoritesAliexpries(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.searchByimagealiexpress,
    page: () => const SearchByImageView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Alibaba
  GetPage(
    name: AppRoutesname.homepagealibaba,
    page: () => const HomeAlibaba(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.alibabaByimageView,
    page: () => const AlibabaByimageView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.productDetailsAlibabView,
    page: () => const ProductDetailsAlibabView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // shein
  GetPage(
    name: AppRoutesname.homeSheinView,
    page: () => const HomeSheinView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.productDetailsSheinView,
    page: () => const ProductDetailsSheinView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.productByCategoryShein,
    page: () => const ProductByCategory(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Amazon
  GetPage(
    name: AppRoutesname.homeAmazonView,
    page: () => const AmazonHomeView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.productDetailsAmazonView,
    page: () => const ProductDetailsAmazonView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.productFromCatView,
    page: () => const ProductFromCatView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // address
  GetPage(
    name: AppRoutesname.addAddresses,
    page: () => const AddAddress(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  // Support
  GetPage(
    name: AppRoutesname.messagesScreen,
    page: () => const MessagesScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.chatsScreen,
    page: () => const ChatsScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Checkout
  GetPage(
    name: AppRoutesname.checkout,
    page: () => const CheckoutScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Orders
  GetPage(
    name: AppRoutesname.orderDetails,
    page: () => const OrderDetailsScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.localServiceDetails,
    page: () => const LocalServiceDetailsView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.serviceOrderScreen,
    page: () => const ServiceOrderScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.localServiceOrderDetailsView,
    page: () => const LocalServiceOrderDetailsView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.viewLocalServiceOrders,
    page: () => const ViewLocalServiceOrdersScreen(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.legal,
    page: () => const LegalView(title: ""),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),

  // Our Products (Local Products)
  GetPage(
    name: AppRoutesname.ourProductsView,
    page: () => const OurProductsView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.ourProductDetails,
    page: () => const OurProductDetailsView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
  GetPage(
    name: AppRoutesname.ourProductsSearch,
    page: () => const OurProductsSearchView(),
    transition: transitionType,
    transitionDuration: Duration(milliseconds: transitionDurations),
  ),
];
