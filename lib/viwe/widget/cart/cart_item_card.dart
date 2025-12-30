import 'dart:convert';
import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_details_sheet.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_image.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_info.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_quantity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final CartModel cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final attributes = jsonDecode(cartItem.cartAttributes!);
    final controller = Get.find<CartControllerImpl>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          final plat = cartItem.cartPlatform!.toLowerCase();
          controller.gotoditels(
            id: plat == "aliexpress" || plat == "alibaba"
                ? int.parse(cartItem.productId!)
                : cartItem.productId!,
            lang: plat == "amazon" ? enOrArAmazon() : enOrAr(),
            title: cartItem.cartProductTitle!,
            asin: cartItem.productId ?? "",
            goodssn: cartItem.goodsSn ?? "",
            goodsid: cartItem.productId ?? "",
            categoryid: cartItem.categoryId ?? "",
            platform: cartItem.cartPlatform!.toLowerCase(),
          );
        },
        child: Row(
          children: [
            // Image and Delete Button
            CartItemImage(
              imageUrl: cartItem.cartProductImage,
              onDelete: () => controller.removeItem(cartItem.cartId!),
            ),

            const SizedBox(width: 15),

            // Product Info (Title, Price, More)
            CartItemInfo(
              title: cartItem.cartProductTitle!,
              price: cartItem.cartPrice!,
              onShowMore: () => CartItemDetailsSheet.show(context, attributes),
            ),

            // Quantity Controls
            CartItemQuantity(cartItem: cartItem, controller: controller),
          ],
        ),
      ),
    );
  }
}
