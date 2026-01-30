import 'package:e_comerece/controller/our_products/our_products_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/our_products_categories_list.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/our_products_grid.dart';
import 'package:e_comerece/viwe/screen/our_products/widgets/our_products_search_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OurProductsView extends StatelessWidget {
  const OurProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OurProductsController());

    return Scaffold(
      backgroundColor: Appcolor.white2,
      body: Stack(
        children: [
          const PositionedRight1(),
          const PositionedRight2(),
          _buildContent(),
          _buildAppBar(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        SizedBox(height: 120.h),
        const OurProductsSearchBar(),
        SizedBox(height: 16.h),
        const OurProductsCategoriesList(),
        SizedBox(height: 16.h),
        const Expanded(child: OurProductsGrid()),
      ],
    );
  }

  Widget _buildAppBar() {
    return PositionedAppBar(
      title: StringsKeys.ourProducts.tr,
      onPressed: () => Get.back(),
    );
  }
}
