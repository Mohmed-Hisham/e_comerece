import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/controller/cart/add_or_rmove_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/displayattributes.dart';
import 'package:e_comerece/data/model/cartmodel.dart';
import 'package:e_comerece/data/model/itemdetelis_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartBottomSheet extends StatelessWidget {
  final ProductDetailsController controller;

  const AddToCartBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    AddorrmoveControllerimple addcontroller = Get.put(
      AddorrmoveControllerimple(),
    );
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildSelectedAttributes(context, controller),
            const SizedBox(height: 16),
            _buildQuantitySelector(context, controller, addcontroller),
            const SizedBox(height: 24),
            _buildAddToCartButton(context, addcontroller, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String? imageUrl;
    if (controller.currentSku != null) {
      final selectedSkuIds = controller.currentSku!.skuPropIds?.split(',');
      if (selectedSkuIds != null) {
        for (var attribute
            in controller.itemDetails!.skuComponent!.productSKUPropertyList!) {
          for (var value in attribute.skuPropertyValues!) {
            if (selectedSkuIds.contains(value.propertyValueId.toString())) {
              if (value.skuPropertyImagePath != null &&
                  value.skuPropertyImagePath!.isNotEmpty) {
                imageUrl = value.skuPropertyImagePath;
                break;
              }
            }
          }
          if (imageUrl != null) break;
        }
      }
    }

    if (imageUrl == null &&
        (controller.itemDetails?.productInfoComponent?.imageList?.isNotEmpty ??
            false)) {
      imageUrl = controller.itemDetails!.productInfoComponent!.imageList![0];
    }

    return Row(
      children: [
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller
                        .currentSku
                        ?.skuVal
                        ?.skuActivityAmount
                        ?.formatedAmount ??
                    '',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
              Text(
                'Stock: ${controller.currentSku?.skuVal?.availQuantity ?? ''}',
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
            controller.quantity.value = 1;
          },
        ),
      ],
    );
  }

  Widget _buildSelectedAttributes(
    BuildContext context,
    ProductDetailsController controller,
  ) {
    final attributes =
        controller.itemDetails?.skuComponent?.productSKUPropertyList;
    if (attributes == null || attributes.isEmpty) {
      return const SizedBox.shrink();
    }
    List<Widget> selectedAttributeWidgets = [];
    for (var attribute in attributes) {
      final selectedValueId =
          controller.selectedAttributes[attribute.skuPropertyId!];
      if (selectedValueId != null) {
        final selectedValue = attribute.skuPropertyValues?.firstWhere(
          (value) => value.propertyValueId.toString() == selectedValueId,
          orElse: () => SkuPropertyValues(),
        );
        if (selectedValue?.propertyValueDisplayName != null) {
          List<Widget> rowChildren = [
            Text(
              '${attribute.skuPropertyName}: ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              selectedValue!.propertyValueDisplayName!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ];

          if (selectedValue.skuPropertyImagePath != null &&
              selectedValue.skuPropertyImagePath!.isNotEmpty) {
            rowChildren.insert(
              0,
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CachedNetworkImage(
                  imageUrl: selectedValue.skuPropertyImagePath!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }

          selectedAttributeWidgets.add(Row(children: rowChildren));
          selectedAttributeWidgets.add(const SizedBox(height: 8));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectedAttributeWidgets,
    );
  }

  Widget _buildQuantitySelector(
    BuildContext context,
    ProductDetailsController controller,
    AddorrmoveControllerimple addcontroller,
  ) {
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
                    productId: controller.productId!,
                    cartAttributes: attributesJson,
                    cartQuantity: controller.quantity.value.toString(),
                  ),
                );
              },
            ),
            Obx(
              () => Text(
                controller.quantity.value.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                    productId: controller.productId!,
                    cartAttributes: attributesJson,
                    cartQuantity: controller.quantity.value.toString(),
                  ),
                  availablequantity:
                      controller.currentSku?.skuVal?.availQuantity
                          ?.toString() ??
                      "0",
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(
    BuildContext context,
    AddorrmoveControllerimple cartController,
    ProductDetailsController controller,
  ) {
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

          final productId =
              controller.itemDetails?.productInfoComponent?.productId
                  ?.toString() ??
              '';
          final subject =
              controller.itemDetails?.productInfoComponent?.subject
                  ?.toString() ??
              '';
          final imageUrl =
              controller
                      .itemDetails
                      ?.productInfoComponent
                      ?.imageList
                      ?.isNotEmpty ==
                  true
              ? controller.itemDetails!.productInfoComponent!.imageList![0]
                    .toString()
              : '';
          final price =
              controller.currentSku?.skuVal?.skuActivityAmount?.formatedAmount
                  ?.toString() ??
              '0';
          // final attributes = jsonEncode(controller.selectedAttributes);
          final stock =
              controller.currentSku?.skuVal?.availQuantity?.toString() ?? '0';
          // final attributesIds = jsonEncode(
          //   controller.selectedAttributes,
          // ); // الـ IDs للحفظ
          // final attributesDisplay = jsonEncode(
          //   displayAttributes,
          // ); // الأسماء للعرض
          print(productId);
          print(subject);
          print(imageUrl);
          print(price);
          print(attributesJson);
          print(stock);
          // print(attributesDisplay);
          // print(attributesIds);
          print(controller.quantity.value.toString());
          cartController.add(
            productId,
            subject,
            imageUrl,
            price,
            "aliexpress",
            controller.quantity.value.toString(),
            attributesJson,
            stock,
          );
          Get.back(); // Close the bottom sheet
        },
        child: const Text("Add to Cart"),
      ),
    );
  }
}
