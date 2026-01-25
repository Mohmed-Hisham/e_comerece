import 'package:e_comerece/controller/cart/cart_controller.dart';
import 'package:e_comerece/core/class/handlingdataviwe.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/viwe/screen/shein/cust_label_container.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_app_bar.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_1.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_right_2.dart';
import 'package:e_comerece/viwe/widget/Positioned/positioned_support.dart';
import 'package:e_comerece/viwe/widget/cart/cart_item_card.dart';
import 'package:e_comerece/viwe/widget/cart/checkout_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(CartControllerImpl());
    return Scaffold(
      body: Stack(
        children: [
          PositionedRight1(),
          PositionedRight2(),
          PositionedAppBar(title: StringsKeys.cart.tr),
          GetBuilder(
            init: CartControllerImpl()..getCartItems(),
            builder: (controller) {
              return Handlingdataviwe(
                statusrequest: controller.statusrequest,
                widget: Column(
                  children: [
                    SizedBox(height: 90.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 270.h),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.cartByPlatform.keys.length,
                        itemBuilder: (context, index) {
                          String platform = controller.cartByPlatform.keys
                              .elementAt(index);
                          List<CartData> cartItems =
                              controller.cartByPlatform[platform]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Row(
                                children: [CustLabelContainer(text: platform)],
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  final cartItem = cartItems[index];
                                  return CartItemCard(cartItem: cartItem);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 60.h),
                  ],
                ),
              );
            },
          ),
          PositionedSupport(
            onPressed: () {
              Get.toNamed(
                AppRoutesname.messagesScreen,
                arguments: {"platform": 'Cart'},
              );
            },
          ),
          Positioned(bottom: 75.h, left: 0.w, right: 0.w, child: CheckoutBar()),
        ],
      ),
    );
  }
}
