import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/viwe/screen/favorite_view.dart';
import 'package:e_comerece/viwe/screen/home/homepage.dart';
import 'package:e_comerece/viwe/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomescreenController extends GetxController {
  changepage(int i);

  goToFavorit();
  gotocart();
}

class HomescreenControllerImple extends HomescreenController {
  int pageindex = 0;

  List<Widget> pages = [
    Homepage(),
    FavoriteScreen(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Cart')],
    ),
    Setting(),
  ];
  List nameBottonBar = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'noti', 'icon': Icons.notifications_active_outlined},
    {'title': 'profail', 'icon': Icons.person_pin_rounded},
    {'title': 'Setteings', 'icon': Icons.settings},
  ];

  @override
  changepage(int i) {
    pageindex = i;
    update();
  }

  @override
  goToFavorit() {
    Get.toNamed(AppRoutesname.favoritescreen);
  }

  @override
  gotocart() {
    Get.toNamed(AppRoutesname.cartscreen);
  }
}
