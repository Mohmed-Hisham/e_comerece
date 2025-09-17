import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CuststockInfo extends StatelessWidget {
  const CuststockInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      id: 'selectedAttributes',
      builder: (controller) {
        final stock = controller.currentSku?.skuVal?.availQuantity;
        if (stock == null) return const SizedBox.shrink();
        return Row(
          children: [
            Text(
              'Available Stock:',
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
