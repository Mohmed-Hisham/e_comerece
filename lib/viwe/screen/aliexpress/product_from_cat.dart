import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/shearchname_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductFromCat extends StatelessWidget {
  const ProductFromCat({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShearchnameControllerImple());
    Get.put(FavoritesController());
    return Scaffold(
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
              final int itemCount = controller.categorymodel.isNotEmpty
                  ? controller.categorymodel.length
                  : controller.categorymodelFromImage.length;

              return Column(
                children: [
                  SizedBox(height: 70),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final bool useModel =
                            controller.categorymodel.isNotEmpty;

                        // اختر العنصر الحالي من اللستة الصحيحة
                        final dynamic current = useModel
                            ? controller.categorymodel[index]
                            : controller.categorymodelFromImage[index];

                        // احصل على الـ id و name بطريقة مأمونة
                        final int currentId = useModel
                            ? (current.id ?? 0)
                            : int.tryParse(current.id.toString()) ?? 0;
                        final String currentName = current.name ?? 'Unknown';

                        // IconData من الخريطة أو أيقونة افتراضية
                        final IconData iconToShow =
                            categoryIcons[currentId] ??
                            FontAwesomeIcons.tableCellsLarge;

                        // هل العنصر محدد؟
                        final bool isSelected =
                            controller.categoryId == currentId ||
                            controller.selectedIndex == index;

                        // اختر وِيدجت الأيقونة: FaIcon إن كانت من FontAwesome، وإلا Icon
                        final Widget iconWidget =
                            (iconToShow.fontPackage != null &&
                                iconToShow.fontPackage ==
                                    'font_awesome_flutter')
                            ? FaIcon(
                                iconToShow,
                                size: 24,
                                color: Appcolor.black2,
                              )
                            : Icon(
                                iconToShow,
                                size: 24,
                                color: Appcolor.black2,
                              );

                        return InkWell(
                          onTap: () {
                            controller.changeCat(currentName, currentId, index);
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
                                      child: Center(child: iconWidget),
                                    ),
                                    // show popup only if there are subCategories available and we're using the model
                                    if (useModel &&
                                        (current.subCategories != null &&
                                            (current.subCategories as List)
                                                .isNotEmpty))
                                      Custmenubutton(
                                        onSelected: (p0) {
                                          String name = p0!["name"].toString();
                                          int id = int.parse(
                                            p0["id"].toString(),
                                          );
                                          controller.changeCat(name, id, index);
                                        },
                                        itemBuilder: (context) =>
                                            (current.subCategories as List).map(
                                              (sub) {
                                                return PopupMenuItem(
                                                  value: {
                                                    "id": sub.id,
                                                    "name": sub.name,
                                                  },
                                                  child: Text(
                                                    sub.name ?? 'Unknown',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                      ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  width: 100,
                                  child: Text(
                                    currentName,
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
                                    color: controller.categoryId == currentId
                                        ? (isSelected
                                              ? Appcolor.primrycolor
                                              : Colors.transparent)
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
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!controller.isLoading &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent * 0.8 &&
                            controller.hasMore) {
                          controller.loadMoreSearch();
                        }
                        return true;
                      },
                      child: Handlingdataviwe(
                        // shimmer: ShimmerGrideviwe(),
                        statusrequest: controller.statusrequest,
                        widget: RefreshIndicator(
                          onRefresh: () => controller.fetchShearchname(
                            controller.nameCat!,
                            controller.categoryId!,
                            isLoadMore: false,
                          ),
                          child: GridView.builder(
                            key: Key(controller.categoryId.toString()),
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
                                    placeholder: (context, url) => const Center(
                                      child: ShimmerImageProduct(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  disc: calculateDiscountPercent(
                                    product.item!.sku!.def!.price!,
                                    product.item!.sku!.def!.promotionPrice!,
                                  ),
                                  title: product.item!.title!,
                                  price:
                                      product.item!.sku!.def!.promotionPrice!,
                                  icon: GetBuilder<FavoritesController>(
                                    builder: (isFavoriteController) {
                                      bool isFav =
                                          isFavoriteController
                                              .isFavorite[product
                                              .item!
                                              .itemId] ??
                                          false;

                                      return IconButton(
                                        onPressed: () {
                                          isFavoriteController.toggleFavorite(
                                            product.item!.itemId!.toString(),
                                            product.item!.title!,
                                            product.item!.itemUrl!,
                                            product
                                                .item!
                                                .sku!
                                                .def!
                                                .promotionPrice!,
                                            "Aliexpress",
                                          );
                                        },
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? Colors.red
                                              : Colors.black,
                                          size: 25,
                                        ),
                                      );
                                    },
                                  ),
                                  discprice: product.item!.sku!.def!.price!,
                                  countsall: "${product.item!.sales!} مبيعة",
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLoading && controller.hasMore)
                    ShimmerBar(height: 8, animationDuration: 1),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
