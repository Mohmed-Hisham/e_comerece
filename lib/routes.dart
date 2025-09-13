import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/middleware/middleware.dart';
import 'package:e_comerece/test_viwe.dart';
import 'package:e_comerece/viwe/screen/aliexpress/favorites_aliexpries.dart';
import 'package:e_comerece/viwe/screen/aliexpress/searchname.dart';
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
import 'package:e_comerece/viwe/screen/home/homepage.dart';
import 'package:e_comerece/viwe/screen/home/homescreen.dart';
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
    // middlewares: [MyMiddleware()],
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
  GetPage(name: AppRoutesname.homepage, page: () => const Homescreen()),
  GetPage(name: AppRoutesname.detelspage, page: () => ProductDetailsView()),
  GetPage(name: AppRoutesname.shearchname, page: () => Shearchname()),
  GetPage(name: AppRoutesname.favoritescreen, page: () => FavoriteScreen()),
  GetPage(name: AppRoutesname.cartscreen, page: () => CartView()),

  //Aliexpress
  GetPage(
    name: AppRoutesname.favoritealiexpress,
    page: () => const FavoritesAliexpries(),
  ),
];
