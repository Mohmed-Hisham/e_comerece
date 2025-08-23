import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/viwe/widget/cart/cart_item_card.dart';
import 'package:e_comerece/viwe/widget/cart/checkout_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          print("build");
          return Handlingdataviwe(
            statusrequest: controller.statusrequest,
            widget: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = controller.cartItems[index];
                      return CartItemCard(cartItem: cartItem);
                    },
                  ),
                ),
                CheckoutBar(totalPrice: controller.total()),
              ],
            ),
          );
        },
      ),
    );
  }
}
