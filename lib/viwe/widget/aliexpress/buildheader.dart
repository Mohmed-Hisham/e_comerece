import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buildheader extends StatelessWidget {
  final ProductDetailsController controller;

  const Buildheader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (controller.currentSku != null) {
      final selectedSkuIds = controller.currentSku!.skuPropIds?.split(',');
      if (selectedSkuIds != null) {
        for (var attribute in controller.uiSkuProperties) {
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

    if (imageUrl == null && (controller.imageList.isNotEmpty)) {
      imageUrl = controller.imageList[0];
    }

    return Row(
      children: [
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: CachedNetworkImage(
              imageUrl: "https:$imageUrl",
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
            // controller.quantity.value = 1;
          },
        ),
      ],
    );
  }
}
