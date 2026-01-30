import 'package:e_comerece/controller/home/homescreen_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/screen/home/homenavbar.dart';
import 'package:e_comerece/viwe/widget/home/custombottonbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Custbottonappbar extends StatelessWidget {
  const Custbottonappbar({super.key});

  // ✅ Cache the button data
  static const List<Map<String, String>> _buttonData = [
    {'title': 'Home', 'icon': 'assets/svg/home_icon.svg'},
    {'title': 'Cart', 'icon': 'assets/svg/cart_icon.svg'},
    {'title': 'Orders', 'icon': 'assets/svg/orders_icon.svg'},
    {'title': 'Services', 'icon': 'assets/svg/local_service.svg'},
    {'title': 'Profile', 'icon': 'assets/svg/persson_icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomescreenControllerImple>(
      id: 'bottomBar', // ✅ تحديث فقط عند الحاجة
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
              text: _buttonData[i]['title']!,
              iconPath: _buttonData[i]['icon']!,
              onPressed: () => Homenavbar.navigateToTab(i),
              isactive: controller.pageindexHome == i,
            );
          }),
        ),
      ),
    );
  }
}
