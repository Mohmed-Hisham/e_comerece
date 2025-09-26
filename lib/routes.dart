import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/middleware/middleware.dart';
import 'package:e_comerece/viwe/screen/alibaba/alibaba_byImage_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/home_alibaba_view.dart';
import 'package:e_comerece/viwe/screen/alibaba/product_details_alibab_view.dart';
import 'package:e_comerece/viwe/screen/aliexpress/favorites_aliexpries.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_from_cat.dart';
import 'package:e_comerece/viwe/screen/aliexpress/searchbyImage_view.dart';
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
import 'package:e_comerece/viwe/screen/onboarding.dart';
import 'package:e_comerece/viwe/screen/aliexpress/product_details_view.dart';
import 'package:e_comerece/viwe/screen/splashscreen/splashscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

List<GetPage<dynamic>>? routes = [
  // Onboarding
  GetPage(
    name: "/",
    page: () => const MyLanguage(),
    middlewares: [MyMiddleware()],
  ),
  // GetPage(name: "/", page: () => const Onbording()),
  GetPage(name: AppRoutesname.onBoarding, page: () => const Onbording()),
  //splash
  GetPage(
    name: AppRoutesname.splash,
    page: () => const Splashscreen(),
    transition: Transition.fade,
  ),

  // Auth
  GetPage(
    name: AppRoutesname.loginStepOne,
    page: () => const LoginStepOne(),
    transition: Transition.fade,
  ),
  GetPage(
    name: AppRoutesname.login,
    page: () => const Login(),
    transition: Transition.fade,
  ),
  GetPage(
    name: AppRoutesname.sginin,
    page: () => const Sginup(),
    transition: Transition.fade,
  ),
  GetPage(
    name: AppRoutesname.forgetpassword,
    page: () => const Forgetpassword(),
  ),
  GetPage(name: AppRoutesname.verFiyCode, page: () => const Veryfiycode()),
  GetPage(
    name: AppRoutesname.verFiyCodeSignUp,
    page: () => const Verifycodesignup(),
  ),
  GetPage(name: AppRoutesname.resetPassWord, page: () => const Resetpassword()),
  GetPage(name: AppRoutesname.successReset, page: () => const Successreset()),
  GetPage(
    name: AppRoutesname.successsginup,
    page: () => const SuccessSignUpView(),
  ),

  // Home
  GetPage(name: AppRoutesname.homepage1, page: () => const HomePage1()),
  GetPage(name: AppRoutesname.homepage, page: () => const Homenavbar()),
  GetPage(
    name: AppRoutesname.detelspage,
    page: () => const ProductDetailsView(),
  ),
  GetPage(name: AppRoutesname.shearchname, page: () => const ProductFromCat()),
  GetPage(
    name: AppRoutesname.favoritescreen,
    page: () => const FavoriteScreen(),
  ),
  GetPage(name: AppRoutesname.cartscreen, page: () => const CartView()),

  //Aliexpress
  GetPage(
    name: AppRoutesname.favoritealiexpress,
    page: () => const FavoritesAliexpries(),
  ),
  GetPage(
    name: AppRoutesname.searchByimagealiexpress,
    page: () => const SearchByImageView(),
  ),

  // Alibaba
  GetPage(name: AppRoutesname.Homepagealibaba, page: () => const HomeAlibaba()),
  GetPage(
    name: AppRoutesname.AlibabaByimageView,
    page: () => const AlibabaByimageView(),
  ),
  GetPage(
    name: AppRoutesname.ProductDetailsAlibabView,
    page: () => const ProductDetailsAlibabView(),
  ),
  // GetPage(
  //   name: AppRoutesname.FavoritesAlibaba,
  //   page: () => const FavoritesAlibaba(),
  // ),
];
