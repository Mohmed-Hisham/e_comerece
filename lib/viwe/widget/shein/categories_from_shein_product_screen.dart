import 'dart:developer';

import 'package:e_comerece/controller/shein/product_by_category_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CategoriesFromSheinProductScreen extends StatelessWidget {
  const CategoriesFromSheinProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return GetBuilder<ProductByCategoryControllerImple>(
      builder: (controller) {
        final int itemCount = controller.categories.length;

        if (itemCount > 0 && controller.categoryid.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final selectedIndex = controller.categories.indexWhere(
              (cat) => cat.catId == controller.categoryid,
            );
            log(selectedIndex.toString());
            if (selectedIndex == 0 || selectedIndex == 1) {
              return;
            }
            if (selectedIndex != -1) {
              final screenWidth = MediaQuery.of(context).size.width;
              final offset = (screenWidth / 2) - 50;
              final targetPosition = (selectedIndex * 110.0) - offset;

              if (scrollController.hasClients) {
                scrollController.animateTo(
                  targetPosition,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              }
            }
          });
        }
        return SizedBox(
          height: 120.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final current = controller.categories[index];
              final String currentId = (current.catId ?? '');
              final String currentName =
                  current.catName ?? StringsKeys.unknown.tr;

              int id = int.tryParse(currentId) ?? 88888888;
              final IconData iconToShow =
                  categoryIcons[id] ?? FontAwesomeIcons.tableCellsLarge;

              final bool isSelected = controller.categoryid == currentId;

              final Widget iconWidget =
                  (iconToShow.fontPackage != null &&
                      iconToShow.fontPackage == 'font_awesome_flutter')
                  ? FaIcon(
                      iconToShow,
                      size: 26.sp,
                      color: isSelected
                          ? Appcolor.primrycolor
                          : Appcolor.black2,
                    )
                  : Icon(iconToShow, size: 26.sp, color: Appcolor.black2);

              return InkWell(
                onTap: () {
                  controller.changeCat(currentName, currentId, index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  width: 110.w,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Appcolor.white,
                              border: Border.all(
                                color: isSelected
                                    ? Appcolor.primrycolor
                                    : Appcolor.threecolor,
                                width: 4.w,
                              ),
                              borderRadius: BorderRadius.circular(60.r),
                            ),
                            child: Center(child: iconWidget),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 110.w,
                        child: Text(
                          currentName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isSelected
                                ? Appcolor.primrycolor
                                : Appcolor.black2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
