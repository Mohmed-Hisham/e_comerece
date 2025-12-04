import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImpl>(
      builder: (controller) {
        return Handlingdataviwe(
          shimmer: CategoriesShimmer(),
          statusrequest: controller.statusrequest,
          widget: SizedBox(
            height: 120.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 10.w),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                final IconData iconToShow =
                    categoryIcons[category.id] ?? Icons.category_outlined;
                return SizedBox(
                  width: 120.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.gotoshearchname(
                                category.name ?? "",
                                category.id!,
                              );
                            },

                            child: Container(
                              height: 60.h,
                              width: 55.w,
                              decoration: BoxDecoration(
                                color: Appcolor.white,
                                border: Border.all(
                                  color: Appcolor.threecolor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(70.r),
                              ),
                              child: Icon(iconToShow, color: Appcolor.black2),
                            ),
                          ),
                          Custmenubutton(
                            onSelected: (p0) {
                              String name = p0!["name"].toString();
                              int id = int.parse(p0["id"].toString());
                              controller.gotoshearchname(name, id);
                            },
                            itemBuilder: (context) =>
                                category.subCategories!.map((sub) {
                                  return PopupMenuItem(
                                    value: {"id": sub.id, "name": sub.name},
                                    child: Text(
                                      sub.name ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                      Container(
                        // alignment: Alignment.center,
                        padding: EdgeInsets.all(6.w),
                        width: 120.w,
                        child: Text(
                          category.name ?? "",
                          // textAlign: TextAlign.center,
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
