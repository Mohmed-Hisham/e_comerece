import 'dart:convert';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/cart_from_detils.dart';
import 'package:e_comerece/controller/favorite/favorites_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:e_comerece/viwe/screen/aliexpress/add_to_cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustbuttonAddCart extends StatelessWidget {
  final AddorrmoveControllerimple addcontroller;
  final String? tag;
  const CustbuttonAddCart({super.key, required this.addcontroller, this.tag});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 1,
      left: Get.width * 0.20,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GetBuilder<ProductDetailsControllerImple>(
          tag: tag,
          id: 'selectedAttributes',
          builder: (controller) {
            if (controller.statusrequest == Statusrequest.loading ||
                controller.statusrequest == Statusrequest.failuer ||
                controller.statusrequest == Statusrequest.serverfailuer ||
                controller.statusrequest == Statusrequest.oflinefailuer ||
                controller.statusrequest == Statusrequest.noData) {
              return const SizedBox();
            } else {
              return Row(
                spacing: 20,
                children: [
                  GetBuilder<FavoritesController>(
                    builder: (favorite) {
                      bool isFav =
                          favorite.isFavorite[controller.productId
                              .toString()] ??
                          false;

                      return Container(
                        decoration: BoxDecoration(
                          color: Appcolor.soecendcolor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            favorite.toggleFavorite(
                              controller.productId.toString(),
                              controller.itemDetailsModel!.result!.item!.title!,
                              controller
                                  .itemDetailsModel!
                                  .result!
                                  .item!
                                  .images[0],
                              controller.getRawUsdPrice().toString(),
                              "Aliexpress",
                            );
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite,
                            color: isFav ? Colors.red : Colors.white,
                            size: 26.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primrycolor,
                      foregroundColor: Appcolor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                    ),
                    onPressed:
                        controller.currentSku?.skuVal?.availQuantity == 0 ||
                            controller.currentSku?.skuVal?.availQuantity == null
                        ? null
                        : () {
                            controller.getquiqtity(
                              jsonEncode(buildDisplayAttributes(controller)),
                            );
                            Get.bottomSheet(
                              AddToCartBottomSheet(
                                controller: controller,
                                addcontroller: addcontroller,
                                tag: controller.productId.toString(),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            );
                          },
                    child: Text(StringsKeys.addToCart.tr),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
