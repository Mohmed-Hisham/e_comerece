import 'dart:developer';

import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesShein extends StatelessWidget {
  const CategoriesShein({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSheinControllerImpl>(
      builder: (controller) {
        return Handlingdataviwe(
          shimmer: CategoriesShimmer(),
          statusrequest: controller.statusrequestcat,
          widget: SizedBox(
            height: 110.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 10.w),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                int id = int.parse(category.catId.toString());
                final IconData iconToShow =
                    categoryIcons[id] ?? Icons.category_outlined;

                return Container(
                  width: 110.w,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              log(category.catId.toString());
                              controller.goTOProductByCat(
                                category.catId.toString(),
                                category.catName ?? "",
                              );
                            },
                            // create circle with border
                            child: ClipOval(
                              child: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  border: Border.all(
                                    color: Appcolor.threecolor,
                                    width: 3.w,
                                  ),
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Icon(iconToShow, color: Appcolor.black2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4.w),
                        width: 110.w,
                        child: Text(
                          category.catName!,
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
