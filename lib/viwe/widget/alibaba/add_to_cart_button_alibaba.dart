import 'dart:convert';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/toggle_favorite_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/servises/selected_attributes_tomap_fordb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddToCartButtonAlibaba extends StatelessWidget {
  final AddorrmoveControllerimple cartController;
  final String? tag;
  const AddToCartButtonAlibaba({
    super.key,
    required this.cartController,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      tag: tag,
      id: 'quantity',
      builder: (controller) {
        final bool isInCart = controller.isInCart;
        final bool isAvailable = controller.isProductAvailable();
        // log("isInCart=>$isInCart");
        // log("quantity=>${controller.quantity}");
        // log("cartquantity=>${controller.cartquantityDB}");
        // print("isfav=>${controller.isFavorite}");

        if (isInCart && controller.quantity == controller.cartquantityDB) {}

        return Column(
          spacing: 4,
          children: [
            if (isInCart)
              Text(
                StringsKeys.itemInCartMessage.tr,
                style: const TextStyle(fontSize: 11),
              ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: SizedBox(
                    // width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          isAvailable &&
                              (!isInCart ||
                                  controller.quantity !=
                                      controller.cartquantityDB)
                          ? () async {
                              final imageurl = selectedAttributesToMapForDb(
                                controller.selectedAttributes,
                              ).values.first['image'];

                              await cartController.add(
                                porductink: controller.productLink ?? "",
                                controller.productId.toString(),
                                controller.subject.toString(),
                                imageurl == ""
                                    ? controller.imageList[0].toString()
                                    : "",
                                controller.getCurrentPrice() ?? 0.0,
                                'Alibaba',
                                controller.quantity,
                                jsonEncode(
                                  selectedAttributesToMapForDb(
                                    controller.selectedAttributes,
                                  ),
                                ),

                                controller.getCurrentPriceList()?.maxQuantity ??
                                    0,

                                tier: jsonEncode(
                                  priceListToMap(controller.priceListFromModel),
                                ),
                              );

                              controller.getquiqtity(
                                jsonEncode(
                                  selectedAttributesToMapForDb(
                                    controller.selectedAttributes,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isInCart &&
                                controller.quantity != controller.cartquantityDB
                            ? Appcolor.soecendcolor
                            : Appcolor.primrycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            (isInCart &&
                                    controller.quantity !=
                                        controller.cartquantityDB)
                                ? Icons.update
                                : isInCart
                                ? Icons.check
                                : Icons.shopping_cart,
                            color: Appcolor.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (isInCart &&
                                    controller.quantity !=
                                        controller.cartquantityDB)
                                ? StringsKeys.updateQuantity.tr
                                : isInCart
                                ? StringsKeys.addedToCartLabel.tr
                                : StringsKeys.addToCart.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                GetBuilder<TogglefavoriteController>(
                  builder: (favoritesController) {
                    favoritesController.currentStatus = controller.isFavorite;
                    return IconButton(
                      onPressed: () {
                        controller.changisfavorite();
                        favoritesController.toggleFavorite(
                          controller.productId.toString(),
                          controller.subject.toString(),
                          controller.imageList[0].toString(),
                          controller.getCurrentPrice()?.toString() ?? "0.0",
                          "Alibaba",
                        );
                      },
                      icon: FaIcon(
                        controller.isFavorite
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: controller.isFavorite
                            ? Appcolor.reed
                            : Appcolor.reed,
                      ),
                    );
                  },
                ),
              ],
            ),

            if (isInCart)
              Text(
                StringsKeys.changeOptionsMessage.tr,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        );
      },
    );
  }
}
