import 'dart:convert';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Buildaddtocartbutton extends StatelessWidget {
  final AddorrmoveControllerimple cartController;
  final ProductDetailsControllerImple controller;
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
          final stock = controller.currentSku?.skuVal?.availQuantity ?? 0;

          cartController.add(
            productId,
            subject,
            controller.imgageAttribute ?? imageUrl,
            controller.getRawUsdPrice(),
            "aliexpress",
            controller.quantity,
            attributesJson,
            stock,
            tier: "",
            porductink: controller.productLink ?? "",
          );
          Get.back();
        },
        child: controller.inCart
            ? Text(
                StringsKeys.updateCart.tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              )
            : Text(
                StringsKeys.addToCart.tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
