import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CuststockInfo extends StatelessWidget {
  final String? tag;
  const CuststockInfo({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsControllerImple>(
      tag: tag,
      id: 'selectedAttributes',
      builder: (controller) {
        final stock = controller.currentSku?.skuVal?.availQuantity;
        if (stock == null) return const SizedBox.shrink();
        return Row(
          children: [
            Text(
              '${StringsKeys.availableStock.tr}:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Text(
              '$stock',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.green,
                fontFamily: 'asian',
              ),
            ),
          ],
        );
      },
    );
  }
}
