import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/controller/shein/home_shein_controller.dart';
import 'package:e_comerece/controller/shein/product_details_shein_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/calculateDiscount.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ProductFromDetails extends StatelessWidget {
  const ProductFromDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsSheinControllerImple>(
      id: 'searchProducts',
      builder: (controller) => SliverGrid.builder(
        // padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 300,
        ),
        itemCount: controller.searchProducts.length,
        itemBuilder: (context, index) {
          final product = controller.searchProducts[index];

          return InkWell(
            onTap: () {
              print(product.productUrl);
              print(product.productUrl);
              print(product.goodsId);
              print("product.goodsSn => ${product.goodsSn}");
              print("product.goodsId => ${product.goodsId}");
              print("product.spu => ${product.spu}");
              // controller.gotoditels(
              //   goodssn: product.goodsSn!,
              //   title: product.goodsName!,
              //   goodsid: product.goodsId!,
              // );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Custgridviwe(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: 'https:${product.goodsImg}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Loadingimage(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                disc: calculateDiscountPercent(
                  product.retailPrice!.amount.toString(),
                  product.salePrice?.amount.toString(),
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
                          product.goodsImg!,
                          product.salePrice!.amountWithSymbol.toString(),
                          goodsSn: product.goodsSn ?? "",
                          categoryid: product.catId ?? "",
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
                countsall: product.premiumFlagNew?.seriesBadgeName.toString(),
                rate: product.commentRankAverage.toString(),
                isAlibaba: true,
                images: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    cacheExtent: 500,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: product.relatedColorNew.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            "all ${product.relatedColorNew.length} colors",
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
                                'https:${product.relatedColorNew.map((e) => e.colorImage).toList()[index - 1]}',
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

    // if (controller.isLoadingSearch &&
    //     controller.hasMoresearch &&
    //     controller.pageindex > 0)
    //   ShimmerBar(height: 8, animationDuration: 1),
  }
}
