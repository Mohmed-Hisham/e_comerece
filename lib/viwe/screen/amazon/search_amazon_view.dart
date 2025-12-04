import 'package:e_comerece/controller/amazon_controllers/amazon_home_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/funcations/extractn_umbers.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/amazon/cust_price_amazon.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:e_comerece/viwe/widget/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchAmazonView extends StatelessWidget {
  final AmazonHomeControllerImpl controller;
  const SearchAmazonView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!controller.isLoading) {
          final atEdge = scrollInfo.metrics.atEdge;
          final pixels = scrollInfo.metrics.pixels;
          final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
          if (atEdge && pixels == maxScrollExtent) {
            controller.loadMoreSearch();
          }
        }
        return true;
      },

      child: RefreshIndicator(
        onRefresh: () => controller.searshText(),
        child: Column(
          children: [
            SeetingsPriceAmazon(),

            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(12.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 10.w,
                  mainAxisExtent: 330.h,
                ),
                itemCount: controller.searchProducts.length,
                itemBuilder: (context, index) {
                  final item = controller.searchProducts[index];

                  return InkWell(
                    onTap: () {
                      // log(item.productUrl.toString());
                      // print(item.asin.toString());
                      controller.gotoditels(
                        asin: item.asin.toString(),
                        title: item.productTitle!,
                        lang: enOrArAmazon(),
                      );
                    },
                    child: Custgridviwe(
                      image: CustomCachedImage(imageUrl: item.productPhoto!),
                      disc: calculateDiscountPercent(
                        extractNumbers(item.productPrice.toString()),
                        extractNumbers(item.productOriginalPrice ?? ""),
                      ),
                      title: item.productTitle!,
                      price: extractNumbers(item.productPrice.toString()),
                      icon: GetBuilder<FavoritesController>(
                        builder: (isFavoriteController) {
                          bool isFav =
                              isFavoriteController.isFavorite[item.asin] ??
                              false;

                          return IconButton(
                            onPressed: () {
                              isFavoriteController.toggleFavorite(
                                item.asin!,
                                item.productTitle!,
                                item.productPhoto!,
                                extractNumbers(item.productPrice.toString()),
                                "Amazon",
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
                      isAmazon: true,
                      rate: "${item.productStarRating ?? ""}   ",
                      discprice:
                          extractNumbers(item.productOriginalPrice ?? "") != ""
                          ? extractNumbers(item.productOriginalPrice ?? "")
                          : extractNumbers(item.productPrice.toString()),
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoading &&
                controller.hasMore &&
                controller.pageIndexSearch > 0)
              ShimmerBar(height: 8, animationDuration: 1),
          ],
        ),
      ),
    );
  }
}
