import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/viwe/screen/shein/extension_geter_trending_product.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TrendingProductShein extends GetView<HomeSheinControllerImpl> {
  const TrendingProductShein({super.key});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      isSliver: true,
      // shimmer: ShimmerSliverGridviwe(),
      statusrequest: controller.statusrequestproduct,
      widget: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 300,
        ),

        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];

          return InkWell(
            onTap: () {
              print(product.productUrl);
              print(product.productId);
              print("product.goodsSn => ${product.goodsSn}");
              print("product.goodsId => ${product.goodsId}");
              print("product.categoryId => ${product.categoryId}");

              controller.gotoditels(
                goodssn: product.goodsSn!,
                title: product.goodsName!,
                goodsid: product.goodsId!,
                categoryid: product.categoryId,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custgridviwe(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: product.mainImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                disc: calculateDiscountPercent(
                  product.salePrice?.amountWithSymbol.toString(),
                  product.retailPrice?.usdAmount.toString(),
                ),
                title: product.goodsName!,
                price: product.salePrice!.amountWithSymbol.toString(),
                icon: GetBuilder<FavoritesController>(
                  builder: (controller) {
                    bool isFav =
                        controller.isFavorite[product.goodsId.toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        controller.toggleFavorite(
                          product.goodsId.toString(),
                          product.goodsName!,
                          product.mainImageUrl,
                          product.salePrice!.amountWithSymbol.toString(),
                          goodsSn: product.goodsSn ?? "",
                          categoryid: product.categoryId,
                          "Shein",
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

                discprice: product.retailPrice!.usdAmount.toString(),
                countsall: product.brandName,
                rate: product.commentRankAverageValue.toString(),
                isAlibaba: true,
                images: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    cacheExtent: 500,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: product.relatedColorImages.length + 1,
                    itemBuilder: (context, index) {
                      // log(product.detailImageList.length.toString());
                      // log(product.detailImageList.toString());
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            "all ${product.relatedColorImages.length} colors",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Appcolor.primrycolor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                '${product.relatedColorImages[index - 1]}',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            placeholder: (c, u) =>
                                const ShimmerImageProductSmall(),
                            errorWidget: (c, u, e) => Container(
                              width: 30,
                              height: 30,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image, size: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
