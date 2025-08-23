import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/shearchname_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shearchname extends StatelessWidget {
  const Shearchname({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShearchnameControllerImple());
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<ShearchnameControllerImple>(
          builder: (controller) {
            return Text(controller.nameCat ?? 'Search');
          },
        ),
      ),
      body: GetBuilder<ShearchnameControllerImple>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categorymodel.length,
                  itemBuilder: (context, index) {
                    final category = controller.categorymodel[index];
                    final IconData iconToShow =
                        categoryIcons[category.categoryId] ??
                        Icons.category_outlined;

                    return InkWell(
                      onTap: () {
                        controller.changeCat(
                          category.categoryName,
                          category.categoryId,
                        );
                        print(category.categoryName);
                        print(category.categoryId);
                        print("---------------");
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Appcolor.primrycolor,
                              border: Border.all(
                                color: Appcolor.threecolor,
                                width: 2,
                              ),
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

                          controller.categoryId == category.categoryId
                              ? Container(
                                  width: 50,
                                  color: Appcolor.primrycolor,
                                  height: 6,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Handlingdataviwe(
                  statusrequest: controller.statusrequest,
                  widget: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                    itemCount:
                        controller.shearchNameModel?.itemList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product =
                          controller.shearchNameModel!.itemList![index];
                      return InkWell(
                        onTap: () {
                          controller.gotoditels(product.itemId!);
                        },
                        child: Card(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: '${product.itemMainPic}',
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                product.title ?? '',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    product.originMinPrice!.formatPrice ?? '',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.discount ?? '',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
