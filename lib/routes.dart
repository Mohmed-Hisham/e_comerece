import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/middleware/middleware.dart';
import 'package:e_comerece/viwe/screen/alibaba/alibaba_byImage_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/home_alibaba_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_details_alibab_view.dart';
import 'package:e_comerece/viwe/screen/aliexpress/favorites_aliexpries.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_from_cat.dart';
import 'package:e_comerece/viwe/screen/aliexpress/searchbyImage_view.dart';
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
import 'package:e_comerece/viwe/screen/favorite_view.dart';
import 'package:e_comerece/viwe/screen/home/homenavbar.dart';
import 'package:e_comerece/viwe/screen/language.dart';
import 'package:e_comerece/viwe/screen/maps/add_address.dart';
import 'package:e_comerece/viwe/screen/onboarding.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_details_view.dart';
import 'package:e_comerece/viwe/screen/shein/home_shein_view.dart';
import 'package:e_comerece/viwe/screen/shein/product_details_shein_view.dart';
import 'package:e_comerece/viwe/screen/splashscreen/splashscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

final int transitionDurations = 300;
final Transition transitionType = Transition.cupertino;
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
  // GetPage(
  //   name: AppRoutesname.FavoritesAlibaba,
  //   page: () => const FavoritesAlibaba(),
  // ),

  // GetPage(
  //   name: AppRoutesname.ProductDetailsSheinView,
  //   page: () => const ProductDetailsSheinView(),
  // ),

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
];
