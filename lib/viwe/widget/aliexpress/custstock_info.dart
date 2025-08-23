import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';

class CuststockInfo extends StatelessWidget {
  final ProductDetailsController controller;
  const CuststockInfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final stock = controller.currentSku?.skuVal?.availQuantity;
    if (stock == null) return const SizedBox.shrink();
    return Row(
      children: [
        Text(
          'Available Stock:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 8),
        Text(
          '$stock',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.green),
        ),
      ],
    );
  }
}
