import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/cart/cart_item_card.dart';
import 'package:e_comerece/viwe/widget/cart/checkout_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return GetBuilder<CartController>(
      builder: (controller) {
        print("build");
        return Handlingdataviwe(
          statusrequest: controller.statusrequest,
          widget: Stack(
            children: [
              PositionedRight1(),
              PositionedRight2(),
              PositionedAppBar(title: "Favorites All", onPressed: Get.back),
              Column(
                children: [
                  SizedBox(height: 90.h),
                  Container(
                    height: 580.h,
                    child: ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cartItems[index];
                        return CartItemCard(cartItem: cartItem);
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 70.h,
                left: 0.w,
                right: 0.w,

                child: CheckoutBar(totalPrice: controller.total()),
              ),
            ],
          ),
        );
      },
    );
  }
}
