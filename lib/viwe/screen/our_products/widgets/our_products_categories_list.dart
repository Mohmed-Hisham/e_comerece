import 'package:e_comerece/controller/our_products/our_products_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OurProductsCategoriesList extends GetView<OurProductsController> {
  const OurProductsCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OurProductsController>(
      id: 'categories',
      builder: (controller) {
        return SizedBox(
          height: 45.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              final isSelected = controller.selectedCategoryId == category.id;

              return _buildCategoryItem(
                controller: controller,
                categoryId: category.id,
                categoryName: category.name,
                isSelected: isSelected,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem({
    required OurProductsController controller,
    required String? categoryId,
    required String? categoryName,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: InkWell(
        onTap: () => controller.selectCategory(categoryId),
        borderRadius: BorderRadius.circular(25.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Appcolor.primrycolor : Appcolor.white,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(
              color: isSelected
                  ? Appcolor.primrycolor
                  : Appcolor.gray.withValues(alpha: 0.3),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Appcolor.primrycolor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            categoryName ?? StringsKeys.all.tr,
            style: TextStyle(
              color: isSelected ? Appcolor.white : Appcolor.black,
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
