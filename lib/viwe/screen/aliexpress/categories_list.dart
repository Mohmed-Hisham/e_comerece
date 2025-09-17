import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_categories.dart';
import 'package:flutter/material.dart';
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
            height: 100,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                final IconData iconToShow =
                    categoryIcons[category.id] ?? Icons.category_outlined;
                return Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.gotoshearchname(
                                category.name ?? "",
                                category.id!,
                              );
                            },

                            child: Container(
                              height: 50,
                              width: 50,
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(4),
                        width: 100,
                        child: Text(
                          category.name!,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
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
