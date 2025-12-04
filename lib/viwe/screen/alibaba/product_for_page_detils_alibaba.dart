import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/screen/alibaba/extension_geter_product_home.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductForPageDetilsAlibaba extends StatelessWidget {
  final String? tag;
  const ProductForPageDetilsAlibaba({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      tag: tag,
      id: 'searshText',
      builder: (controller) => Handlingdataviwe(
        isSliver: true,
        shimmer: ShimmerBar(height: 8, animationDuration: 1),
        statusrequest: controller.statusrequestsearch,
        widget: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            mainAxisExtent: 350.h,
          ),

          itemCount: controller.searchProducts.length,
          itemBuilder: (context, index) {
            final product = controller.searchProducts[index];

            return InkWell(
              onTap: () {
                controller.chaingPruduct(
                  id: product.itemid,
                  lang: controller.lang!,
                  title: product.titel,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Custgridviwe(
                  image: CustomCachedImage(imageUrl: product.mainImageUrl),
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
                      physics: const BouncingScrollPhysics(),
                      itemCount: product.imageUrls.length + 1,

                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Text(
                              StringsKeys.allColors.trParams({
                                'number': product.imageUrls.length.toString(),
                              }),

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
                            child: CustomCachedImage(
                              imageUrl: product.imageUrls[index - 1],
                              width: 30,
                              height: 30,
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
