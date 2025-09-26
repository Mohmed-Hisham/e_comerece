import 'dart:convert';
import 'dart:developer';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/toggleFavorite_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/servises/selected_attributes_tomap_fordb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddToCartButtonAlibaba extends StatelessWidget {
  final AddorrmoveControllerimple cartController;
  const AddToCartButtonAlibaba({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsAlibabaControllerImple>(
      id: 'quantity',
      builder: (controller) {
        final bool isInCart = controller.isInCart;
        final bool isAvailable = controller.isProductAvailable();
        log("isInCart=>$isInCart");
        log("quantity=>${controller.quantity}");
        log("cartquantity=>${controller.cartquantityDB}");
        print("isfav=>${controller.isFavorite}");

        if (isInCart && controller.quantity == controller.cartquantityDB) {}

        return Column(
          spacing: 4,
          children: [
            if (isInCart)
              Text(
                'This item (with the chosen options) is already in your cart.',
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
                                controller.productId.toString(),
                                controller.subject.toString(),
                                imageurl ?? controller.imageList[0].toString(),
                                controller.getCurrentPriceFormatted(),
                                'alibaba',
                                controller.quantity.toString(),
                                jsonEncode(
                                  selectedAttributesToMapForDb(
                                    controller.selectedAttributes,
                                  ),
                                ),

                                controller
                                        .getCurrentPriceList()
                                        ?.maxQuantity
                                        .toString() ??
                                    '',
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
                                ? 'ubdate quantity'
                                : isInCart
                                ? 'Added to Cart'
                                : 'Add to Cart',
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
                          controller.getCurrentPriceFormatted(),
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
                "Try changing size, color, or model to add it again.",
                style: const TextStyle(fontSize: 12),
              ),
          ],
        );
      },
    );
  }
}
