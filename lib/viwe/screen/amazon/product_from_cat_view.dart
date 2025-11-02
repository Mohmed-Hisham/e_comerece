import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/shearchname_controller.dart';
import 'package:e_comerece/controller/amazon_controllers/product_from_categories_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/extractn_umbers.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/custmenubutton.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_left_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductFromCatView extends StatelessWidget {
  const ProductFromCatView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    Get.put(ProductFromCategoriesControllerImpl());
    Get.put(FavoritesController());

    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          GetBuilder<ProductFromCategoriesControllerImpl>(
            builder: (controller) {
              return PositionedAppBar(title: 'Categories', onPressed: Get.back);
            },
          ),
          GetBuilder<ProductFromCategoriesControllerImpl>(
            builder: (controller) {
              final int itemCount = controller.categories.length;

              // بعد ما يتم تحميل الفئات وتعيين الـ categoryId
              if (itemCount > 0 && controller.categoryId.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // نحسب موقع العنصر المحدد
                  final selectedIndex = controller.categories.indexWhere(
                    (cat) => cat.id == controller.categoryId,
                  );

                  if (selectedIndex != -1) {
                    // نحسب البوزيشن اللي نسكرول ليه (كل عنصر عرضه 100)
                    final screenWidth = MediaQuery.of(context).size.width;
                    final offset =
                        (screenWidth / 2) - 50; // نص الشاشة - نص العنصر
                    final targetPosition = (selectedIndex * 100.0) - offset;

                    // نتأكد إن الـ controller مرتبط بالـ ListView
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

              return Column(
                children: [
                  SizedBox(height: 80),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final current = controller.categories[index];
                        final String currentId = (current.id ?? '');
                        final String currentName = current.name ?? 'Unknown';
                        final IconData iconToShow =
                            amazonCategoryIcons[currentId] ??
                            FontAwesomeIcons.tableCellsLarge;
                        final bool isSelected =
                            controller.categoryId == currentId ||
                            controller.selectedIndex == index;

                        final Widget iconWidget =
                            (iconToShow.fontPackage != null &&
                                iconToShow.fontPackage ==
                                    'font_awesome_flutter')
                            ? FaIcon(
                                iconToShow,
                                size: 24,
                                color: isSelected
                                    ? Appcolor.primrycolor
                                    : Appcolor.black2,
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
                            padding: const EdgeInsets.only(left: 5),
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
                                          color: isSelected
                                              ? Appcolor.primrycolor
                                              : Appcolor.threecolor,
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(child: iconWidget),
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
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Appcolor.primrycolor
                                          : Appcolor.black2,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                // AnimatedContainer(
                                //   duration: const Duration(milliseconds: 500),
                                //   curve: Curves.easeInOut,
                                //   width: isSelected ? 80 : 0,
                                //   height: 6,
                                //   decoration: BoxDecoration(
                                //     color: controller.categoryId == currentId
                                //         ? (isSelected
                                //               ? Appcolor.primrycolor
                                //               : Colors.transparent)
                                //         : Colors.transparent,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                // ),
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
                        final atEdge = scrollInfo.metrics.atEdge;
                        final pixels = scrollInfo.metrics.pixels;
                        final maxScrollExtent =
                            scrollInfo.metrics.maxScrollExtent;
                        if (atEdge && pixels == maxScrollExtent) {
                          controller.loadMoreOtherProduct();
                        }
                        return true;
                      },
                      child: Handlingdataviwe(
                        // shimmer: ShimmerGrideviwe(),
                        statusrequest: controller.statusrequestOtherProduct,
                        widget: GridView.builder(
                          key: Key(controller.categoryId.toString()),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 260,
                              ),
                          itemCount: controller.otherProduct.length,
                          itemBuilder: (context, index) {
                            final item = controller.otherProduct[index];

                            return InkWell(
                              onTap: () {
                                // log(item.productUrl.toString());
                                // log(item.asin.toString());

                                // controller.gotoditels(
                                //   asin: item.asin.toString(),
                                //   title: item.productTitle!,
                                //   lang: enOrArAmazon(),
                                // );
                              },
                              child: Custgridviwe(
                                image: CachedNetworkImage(
                                  imageUrl: item.productPhoto!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  placeholder: (context, url) =>
                                      const Loadingimage(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                disc: calculateDiscountPercent(
                                  extractNumbers(item.productPrice.toString()),
                                  extractNumbers(
                                    item.productOriginalPrice ?? "",
                                  ),
                                ),
                                title: item.productTitle!,
                                price: extractNumbers(
                                  item.productPrice.toString(),
                                ),
                                icon: GetBuilder<FavoritesController>(
                                  builder: (isFavoriteController) {
                                    bool isFav =
                                        isFavoriteController.isFavorite[item
                                            .asin] ??
                                        false;

                                    return IconButton(
                                      onPressed: () {
                                        isFavoriteController.toggleFavorite(
                                          item.asin!,
                                          item.productTitle!,
                                          item.productPhoto!,
                                          extractNumbers(
                                            item.productPrice.toString(),
                                          ),
                                          "Amazon",
                                        );
                                      },
                                      icon: FaIcon(
                                        isFav
                                            ? FontAwesomeIcons.solidHeart
                                            : FontAwesomeIcons.heart,
                                        color: isFav
                                            ? Appcolor.reed
                                            : Appcolor.reed,
                                      ),
                                    );
                                  },
                                ),
                                isAmazon: true,
                                rate: "${item.productStarRating ?? ""}   ",
                                discprice:
                                    extractNumbers(
                                          item.productOriginalPrice ?? "",
                                        ) !=
                                        ""
                                    ? extractNumbers(
                                        item.productOriginalPrice ?? "",
                                      )
                                    : extractNumbers(
                                        item.productPrice.toString(),
                                      ),
                              ),
                            );
                          },
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
