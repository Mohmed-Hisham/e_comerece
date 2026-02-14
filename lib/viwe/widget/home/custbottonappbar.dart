import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/widget/home/custombottonbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Custbottonappbar extends StatelessWidget {
  const Custbottonappbar({super.key});

  static final List<Map<String, String>> _buttonData = [
    {'titleKey': StringsKeys.navHome, 'icon': 'assets/svg/home_icon.svg'},
    {'titleKey': StringsKeys.navCart, 'icon': 'assets/svg/cart_icon.svg'},
    {'titleKey': StringsKeys.navOrders, 'icon': 'assets/svg/orders_icon.svg'},
    {
      'titleKey': StringsKeys.navServices,
      'icon': 'assets/svg/local_service.svg',
    },
    {'titleKey': StringsKeys.navProfile, 'icon': 'assets/svg/persson_icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'bottomBar',
      builder: (controller) => Container(
        decoration: BoxDecoration(
          color: Appcolor.white2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_buttonData.length, (i) {
            return Custombottonbar(
              text: _buttonData[i]['titleKey']!.tr,
              iconPath: _buttonData[i]['icon']!,
              onPressed: () => controller.changepage(i),
              isactive: controller.pageindexHome == i,
            );
          }),
        ),
      ),
    );
  }
}
