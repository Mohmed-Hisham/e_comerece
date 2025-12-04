import 'dart:convert';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/viwe/widget/aliexpress/buildheader.dart';
import 'package:e_comerece/viwe/widget/aliexpress/buildaddtocartbutton.dart';
import 'package:e_comerece/viwe/widget/buildselectedattributes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartBottomSheet extends StatelessWidget {
  final ProductDetailsControllerImple controller;
  final AddorrmoveControllerimple addcontroller;

  const AddToCartBottomSheet({
    super.key,
    required this.controller,
    required this.addcontroller,
  });

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // انتظار حتى يتم تحميل تفاصيل المنتج
    //   while (controller.itemDetails == null) {
    //     await Future.delayed(const Duration(milliseconds: 100));
    //   }

    // });
    controller.getquiqtity(jsonEncode(buildDisplayAttributes(controller)));

    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Buildheader(controller: controller),
            const SizedBox(height: 16),
            Buildselectedattributes(controller: controller),
            const SizedBox(height: 16),
            _buildQuantitySelector(context, addcontroller),
            const SizedBox(height: 24),
            Buildaddtocartbutton(
              cartController: addcontroller,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(
    BuildContext context,
    AddorrmoveControllerimple addcontroller,
  ) {
    return GetBuilder<ProductDetailsControllerImple>(
      id: 'quantity',
      builder: (controller) {
        print("quantity.quantity======>${controller.quantity}");

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity', style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    final attributesJson = jsonEncode(
                      buildDisplayAttributes(controller),
                    );
                    controller.decrementQuantity();

                    addcontroller.removprise(
                      cartModel: CartModel(
                        productId: controller.productId!.toString(),
                        cartAttributes: attributesJson,
                        cartQuantity: controller.quantity,
                      ),
                    );
                  },
                ),
                GetBuilder<ProductDetailsControllerImple>(
                  builder: (ctrl) {
                    return Text(
                      "${ctrl.quantity}",
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final attributesJson = jsonEncode(
                      buildDisplayAttributes(controller),
                    );
                    controller.incrementQuantity();
                    addcontroller.addprise(
                      cartModel: CartModel(
                        productId: controller.productId!.toString(),
                        cartAttributes: attributesJson,
                        cartQuantity: controller.quantity,
                      ),
                      availablequantity:
                          controller.currentSku?.skuVal?.availQuantity ?? 0,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
