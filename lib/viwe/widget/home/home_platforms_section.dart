import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/widget/home/cust_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePlatformsSection extends StatelessWidget {
  const HomePlatformsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GridView(
        addRepaintBoundaries: true,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10.w,
          mainAxisExtent: 95.h,
          mainAxisSpacing: 10.w,
        ),
        children: [
          // Our Products Button
          InkWell(
            onTap: () => Get.toNamed(AppRoutesname.ourProductsView),
            child: CustCntainer(
              text: StringsKeys.saltk.tr,
              fontsize: 14.sp,
              color: Appcolor.primrycolor,
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(AppRoutesname.homeSheinView),
            child: CustCntainer(
              text: "Shein",
              fontsize: 15.sp,
              color: const Color(0xFF455A2D),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(AppRoutesname.homepagealibaba),
            child: CustCntainer(
              text: "Alibaba",
              fontsize: 15.sp,
              color: const Color(0xFFDFA672),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutesname.homepage1);
            },
            child: CustCntainer(
              fontsize: 13.sp,
              text: "AliExpress",
              color: const Color(0xFF1A6572),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(AppRoutesname.homeAmazonView),
            child: CustCntainer(
              fontsize: 15.sp,
              text: "Amazon",
              color: const Color(0xFF917D55),
            ),
          ),
        ],
      ),
    );
  }
}
