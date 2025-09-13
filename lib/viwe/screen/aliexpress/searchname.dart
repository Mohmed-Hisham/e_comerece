import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/shearchname_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_grideviwe.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shearchname extends StatelessWidget {
  const Shearchname({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShearchnameControllerImple());
    Get.put(FavoritesController());
    return Scaffold(
      // appBar: AppBar(
      //   title: GetBuilder<ShearchnameControllerImple>(
      //     builder: (controller) {
      //       return Text(controller.nameCat ?? 'Search');
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          GetBuilder<ShearchnameControllerImple>(
            builder: (controller) {
              return PositionedAppBar(
                title: controller.nameCat ?? 'Search',
                onPressed: Get.back,
              );
            },
          ),
          GetBuilder<ShearchnameControllerImple>(
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(height: 70),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categorymodel.length,
                      itemBuilder: (context, index) {
                        final category = controller.categorymodel[index];
                        final IconData iconToShow =
                            categoryIcons[category.id] ??
                            Icons.category_outlined;

                        final isSelected =
                            controller.categoryId == category.id ||
                            controller.selectedIndex == index;

                        return InkWell(
                          onTap: () {
                            controller.changeCat(
                              category.name!,
                              category.id!,
                              index,
                            );
                          },
                          child: Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
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
                                      child: Icon(
                                        iconToShow,
                                        color: Appcolor.black2,
                                      ),
                                    ),
                                    Custmenubutton(
                                      onSelected: (p0) {
                                        String name = p0!["name"].toString();
                                        int id = int.parse(p0["id"].toString());
                                        controller.changeCat(name, id, index);
                                      },
                                      itemBuilder: (context) =>
                                          category.subCategories!.map((sub) {
                                            return PopupMenuItem(
                                              value: {
                                                "id": sub.id,
                                                "name": sub.name,
                                              },
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
                                  padding: const EdgeInsets.all(4),
                                  width: 100,
                                  child: Text(
                                    category.name!,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Appcolor.black2,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  width: isSelected ? 80 : 0,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: controller.categoryId == category.id
                                        ? isSelected
                                              ? Appcolor.primrycolor
                                              : Colors.transparent
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Handlingdataviwe(
                      shimmer: ShimmerGrideviwe(),
                      statusrequest: controller.statusrequest,
                      widget: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 260,
                            ),
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final product = controller.items[index];

                          return InkWell(
                            onTap: () {
                              controller.gotoditels(
                                id: product.item!.itemId!,
                                lang: enOrAr(),
                              );
                            },
                            child: Custgridviwe(
                              image: CachedNetworkImage(
                                imageUrl: "https:${product.item!.image!}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const Center(child: ShimmerImageProduct()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              disc: product.item!.sku!.def!.price!,
                              title: product.item!.title!,
                              price: product.item!.sku!.def!.promotionPrice!,
                              icon: GetBuilder<FavoritesController>(
                                builder: (isFavoriteController) {
                                  bool isFav =
                                      isFavoriteController.isFavorite[product
                                          .item!
                                          .itemId] ??
                                      false;

                                  return IconButton(
                                    onPressed: () {
                                      isFavoriteController.toggleFavorite(
                                        product.item!.itemId!.toString(),
                                        product.item!.title!,
                                        product.item!.itemUrl!,
                                        product.item!.sku!.def!.promotionPrice!,
                                        "Aliexpress",
                                      );
                                    },
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav ? Colors.red : Colors.black,
                                      size: 25,
                                    ),
                                  );
                                },
                              ),
                              discprice:
                                  product.item!.sku!.def!.promotionPrice!,
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
        ],
      ),
    );
  }
}
