import 'package:e_comerece/controller/aliexpriess/aliexprise_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/helper/format_price.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchName extends StatelessWidget {
  final HomePageControllerImpl controller;
  const SearchName({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!controller.isLoading) {
          final atEdge = scrollInfo.metrics.atEdge;
          final pixels = scrollInfo.metrics.pixels;
          final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
          if (atEdge && pixels == maxScrollExtent) {
            controller.loadMoreSearch(
              detectLangFromQuery(controller.searchController.text),
            );
          }
        }
        return true;
      },

      child: RefreshIndicator(
        color: Appcolor.primrycolor,
        backgroundColor: Colors.transparent,
        onRefresh: () =>
            controller.searshText(keyWord: controller.searchController.text),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 420.h,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.searchProducts[index].item!;
                  final currencyService = Get.find<CurrencyService>();

                  return InkWell(
                    onTap: () {
                      int id = item.itemId ?? 0;
                      controller.gotoditels(
                        id: id,
                        title: item.title ?? '',
                        lang: detectLangFromQuery(
                          controller.searchController.text,
                        ),
                      );
                    },
                    child: Custgridviwe(
                      image: CustomCachedImage(imageUrl: item.image ?? ''),
                      disc: calculateDiscountPercent(
                        item.sku?.def?.price ?? 0,
                        item.sku?.def?.promotionPrice ?? 0,
                      ),
                      title: item.title ?? '',
                      price: currencyService.convertAndFormat(
                        amount: extractPrice(
                          item.sku?.def?.promotionPrice ?? "0",
                        ),
                        from: 'USD',
                      ),
                      icon: GetBuilder<FavoritesController>(
                        builder: (isFavoriteController) {
                          bool isFav =
                              isFavoriteController.isFavorite[item.itemId
                                  .toString()] ??
                              false;

                          return IconButton(
                            onPressed: () {
                              isFavoriteController.toggleFavorite(
                                item.itemId!.toString(),
                                item.title ?? '',
                                item.image ?? '',
                                currencyService
                                    .convert(
                                      amount: extractPrice(
                                        item.sku?.def?.promotionPrice ?? "0",
                                      ),
                                      from: 'USD',
                                      to: 'USD',
                                    )
                                    .toString(),
                                "Aliexpress",
                              );
                            },
                            icon: FaIcon(
                              isFav
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isFav ? Appcolor.reed : Appcolor.reed,
                            ),
                          );
                        },
                      ),
                      discprice: currencyService.convertAndFormat(
                        amount: extractPrice(item.sku?.def?.price ?? "0"),
                        from: 'USD',
                      ),
                      countsall: "${item.sales ?? 0} ${StringsKeys.sales.tr}",
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoading &&
                controller.hasMoresearch &&
                controller.pageIndexSearch > 0)
              ShimmerBar(height: 8, animationDuration: 1),
          ],
        ),
      ),
    );
  }
}
