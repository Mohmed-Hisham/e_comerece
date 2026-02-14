import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/viwe/widget/home/cust_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePlatformsSection extends StatelessWidget {
  const HomePlatformsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> platforms = [];

    if (AppConfigService.to.showLocalProducts) {
      platforms.add(
        InkWell(
          onTap: () => Get.toNamed(AppRoutesname.ourProductsView),
          child: CustCntainer(
            text: StringsKeys.saltk.tr,
            color: Appcolor.primrycolor,
          ),
        ),
      );
    }
    if (AppConfigService.to.showShein) {
      platforms.add(
        InkWell(
          onTap: () => Get.toNamed(AppRoutesname.homeSheinView),
          child: CustCntainer(
            text: StringsKeys.platformShein.tr,
            color: const Color(0xFF455A2D),
          ),
        ),
      );
    }
    if (AppConfigService.to.showAlibaba) {
      platforms.add(
        InkWell(
          onTap: () => Get.toNamed(AppRoutesname.homepagealibaba),
          child: CustCntainer(
            text: StringsKeys.platformAlibaba.tr,
            color: const Color(0xFFDFA672),
          ),
        ),
      );
    }
    if (AppConfigService.to.showAliExpress) {
      platforms.add(
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutesname.homepage1);
          },
          child: CustCntainer(
            text: StringsKeys.platformAliexpress.tr,
            color: const Color(0xFF1A6572),
          ),
        ),
      );
    }
    if (AppConfigService.to.showAmazon) {
      platforms.add(
        InkWell(
          onTap: () => Get.toNamed(AppRoutesname.homeAmazonView),
          child: CustCntainer(
            text: StringsKeys.platformAmazon.tr,
            color: const Color(0xFF917D55),
          ),
        ),
      );
    }

    if (platforms.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Container(
        height: 95.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            for (int i = 0; i < platforms.length; i++) ...[
              Expanded(child: platforms[i]),
              if (i != platforms.length - 1) SizedBox(width: 10.w),
            ],
          ],
        ),
      ),
    );
  }
}
