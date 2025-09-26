import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmer_image_product.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/core/shared/widget_shared/loadingimage.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductForPageDetilsAlibaba extends StatelessWidget {
  const ProductForPageDetilsAlibaba({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      id: 'searshText',
      builder: (controller) => Handlingdataviwe(
        isSliver: true,
        shimmer: ShimmerBar(height: 8, animationDuration: 1),
        statusrequest: controller.statusrequestsearch,
        widget: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            mainAxisExtent: 280,
          ),

          itemCount: controller.searchProducts.length,
          itemBuilder: (context, index) {
            final product = controller.searchProducts[index];

            return InkWell(
              onTap: () {
                print("productId=>${product.item!.itemUrl}");
                print("productId=>${product.item!.itemId}");
                controller.chaingPruduct(
                  id: product.itemid,
                  titleReload: product.titel,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Custgridviwe(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      cacheKey: product.itemid.toString(),
                      imageUrl: "https:${product.mainImageUrl}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Loadingimage(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  disc: product.skuPriceFormatted,
                  title: product.titel,
                  price: product.skuPriceFormatted,
                  icon: GetBuilder<FavoritesController>(
                    builder: (controller) {
                      bool isFav =
                          controller.isFavorite[product.itemid.toString()] ??
                          false;

                      return IconButton(
                        onPressed: () {
                          controller.toggleFavorite(
                            product.itemid.toString(),
                            product.titel,
                            product.mainImageUrl,
                            product.skuPriceFormatted,
                            "Alibaba",
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

                  discprice: product.skuPriceFormatted,
                  countsall: product.minOrderFormatted,
                  isAlibaba: true,
                  images: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      cacheExtent: 500,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemCount: product.imageUrls.length + 1,

                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Text(
                              "all ${product.imageUrls.length} colors",

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
                              imageUrl: product.imageUrls[index - 1],
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
      ),
    );
  }
}
