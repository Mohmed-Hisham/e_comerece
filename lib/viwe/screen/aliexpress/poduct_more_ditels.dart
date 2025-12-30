import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/calculate_discount.dart';
import 'package:e_comerece/core/helper/custom_cached_image.dart';
import 'package:e_comerece/core/shared/widget_shared/shimmerbar.dart';
import 'package:e_comerece/viwe/widget/custgridviwe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PoductMoreDitels extends StatelessWidget {
  final ProductDetailsControllerImple controller;
  const PoductMoreDitels({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Handlingdataviwe(
      ontryagain: () => controller.searshText(),
      shimmer: ShimmerBar(height: 8, animationDuration: 1),
      statusrequest: controller.statusrequestsearch,
      isSliver: true,
      widget: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          mainAxisExtent: 350.h,
        ),
        itemCount: controller.searchProducts.length,
        itemBuilder: (context, index) {
          final item = controller.searchProducts[index].item!;

          return InkWell(
            onTap: () {
              int id = item.itemId!;
              controller.chaingPruduct(
                id: id,
                title: item.title!,
                lang: controller.lang!,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Custgridviwe(
                image: CustomCachedImage(imageUrl: item.image ?? ""),
                disc: calculateDiscountPercent(
                  item.sku!.def!.price,
                  item.sku!.def!.promotionPrice,
                ),
                title: item.title!,
                price: "${item.sku!.def!.promotionPrice} \$",
                icon: GetBuilder<FavoritesController>(
                  builder: (isFavoriteController) {
                    bool isFav =
                        isFavoriteController.isFavorite[item.itemId
                            .toString()] ??
                        false;

                    return IconButton(
                      onPressed: () {
                        isFavoriteController.toggleFavorite(
                          item.itemId.toString(),
                          item.title ?? "",
                          item.image ?? "",
                          "\$${item.sku!.def!.price}",
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
                discprice: "${item.sku!.def!.price} \$",
                countsall: "${item.sales!} ${StringsKeys.sales.tr}",
              ),
            ),
          );
        },
      ),
    );
  }
}
