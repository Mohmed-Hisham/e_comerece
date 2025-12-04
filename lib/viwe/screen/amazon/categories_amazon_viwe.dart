import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesAmazonViwe extends StatelessWidget {
  const CategoriesAmazonViwe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AmazonHomeControllerImpl>(
      builder: (controller) {
        return Handlingdataviwe(
          shimmer: CategoriesShimmer(),
          statusrequest: controller.statusrequestcat,
          widget: SizedBox(
            height: 100.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                final IconData iconToShow =
                    amazonCategoryIcons[category.id] ?? Icons.category_outlined;
                return Container(
                  width: 120.w,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.goTOProductFromCategory(
                                category.id ?? '',
                                category.name ?? '',
                              );
                            },

                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: Appcolor.white,
                                border: Border.all(
                                  color: Appcolor.threecolor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(iconToShow, color: Appcolor.black2),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4),
                        width: 120.w,
                        child: Text(
                          category.name!,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Appcolor.soecendcolor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
