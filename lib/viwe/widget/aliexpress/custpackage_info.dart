import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custpackageinfo extends StatelessWidget {
  final ProductDetailsControllerImple controller;
  const Custpackageinfo({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final weight = controller.packageWeight;
    final length = controller.packageLength;
    final width = controller.packageWidth;
    final height = controller.packageHeight;
    if (weight == null && (length == null || width == null || height == null)) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsKeys.packageInformation.tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        if (weight != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${StringsKeys.weight.tr}:  ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
                TextSpan(
                  text: '$weight kg',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        if (length != null && width != null && height != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${StringsKeys.dimensions.tr}:  ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
                TextSpan(
                  text: '$length x $width x $height cm',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
