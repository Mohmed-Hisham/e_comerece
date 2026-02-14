import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_details_sheet.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_image.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_info.dart';
import 'package:e_comerece/viwe/widget/cart/widget/cart_item_quantity.dart';
import 'package:e_comerece/core/servises/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  final CartData cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final attributes = cartItem.parsedAttributes;
    final controller = Get.find<CartControllerImpl>();
    final currencyService = Get.find<CurrencyService>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () {
          final plat = cartItem.cartPlatform!.toLowerCase();
          controller.gotoditels(
            id: plat == "aliexpress" || plat == "alibaba"
                ? int.parse(cartItem.productId!)
                : cartItem.productId!,
            lang: plat == "amazon" ? enOrArAmazon() : enOrAr(),
            title: cartItem.productTitle!,
            asin: cartItem.productId ?? "",
            goodssn: cartItem.goodsSn ?? "",
            goodsid: cartItem.productId ?? "",
            categoryid: cartItem.categoryId ?? "",
            platform: cartItem.cartPlatform!.toLowerCase(),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            CartItemImage(
              imageUrl: cartItem.productImage,
              onDelete: () => controller.removeItem(cartItem.id!),
            ),

            SizedBox(width: 12.w),

            // Info
            CartItemInfo(
              title: cartItem.productTitle!,
              price: currencyService.convertAndFormat(
                amount: cartItem.productPrice ?? 0,
                from: 'USD',
              ),
              onShowMore: () => CartItemDetailsSheet.show(context, attributes),
            ),

            SizedBox(width: 8.w),

            // Quantity
            CartItemQuantity(cartItem: cartItem, controller: controller),
          ],
        ),
      ),
    );
  }
}
