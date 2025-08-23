import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';

class Custpackageinfo extends StatelessWidget {
  final ProductDetailsController controller;
  const Custpackageinfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final packageInfo =
        controller.itemDetails?.productInfoComponent?.packageInfo;
    if (packageInfo == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Package Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        if (packageInfo.weight != null)
          Text('Weight: ${packageInfo.weight} kg'),
        if (packageInfo.length != null)
          Text(
            'Dimensions: ${packageInfo.length}x${packageInfo.width}x${packageInfo.height} cm',
          ),
      ],
    );
  }
}
