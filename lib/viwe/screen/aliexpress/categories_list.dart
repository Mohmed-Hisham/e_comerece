import 'package:e_comerece/controller/aliexpriess/category_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImpl>(
      builder: (controller) {
        return HandlingdatRequest(
          statusrequest: controller.statusrequest,
          widget: SizedBox(
            height: 70,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                // final IconData iconToShow =
                //     categoryIcons[category.categoryId] ??
                //     Icons.category_outlined;

                return InkWell(
                  onTap: () {
                    controller.gotoshearchname(
                      category.categoryName,
                      category.categoryId,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Appcolor.primrycolor,
                      border: Border.all(color: Appcolor.threecolor, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolor.black,
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: Offset(-2, 3),
                        ),
                      ],
                    ),
                    width: 100,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Text(
                      category.categoryName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Appcolor.white,
                      ),
                    ),
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
