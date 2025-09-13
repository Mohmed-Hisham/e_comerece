import 'dart:convert';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buildaddtocartbutton extends StatelessWidget {
  final AddorrmoveControllerimple cartController;
  final ProductDetailsController controller;
  const Buildaddtocartbutton({
    super.key,
    required this.cartController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolor.primrycolor,
          foregroundColor: Appcolor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          final attributesJson = jsonEncode(buildDisplayAttributes(controller));

          final productId = controller.productId?.toString() ?? '';
          final subject = controller.subject?.toString() ?? '';
          final imageUrl = controller.imageList.isNotEmpty
              ? controller.imageList[0].toString()
              : '';
          final price =
              controller.currentSku?.skuVal?.skuActivityAmount?.formatedAmount
                  ?.toString() ??
              '0';

          final stock =
              controller.currentSku?.skuVal?.availQuantity?.toString() ?? '0';
          print("stock=>$stock");
          print("quantity=>${controller.quantity}");
          print("price=>$price");
          print("imageUrl=>$imageUrl");
          print("subject=>$subject");
          print("productId=>$productId");
          print("attributesJson=>$attributesJson");

          cartController.add(
            productId,
            subject,
            imageUrl,
            price,
            "aliexpress",
            controller.quantity.toString(),
            attributesJson,
            stock,
          );
          Get.back();
        },
        child: const Text("Add to Cart"),
      ),
    );
  }
}
