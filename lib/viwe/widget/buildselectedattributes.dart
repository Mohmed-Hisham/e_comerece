import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Buildselectedattributes extends StatelessWidget {
  final ProductDetailsControllerImple controller;

  const Buildselectedattributes({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final attributes = controller.uiSkuProperties;
    if (attributes.isEmpty) {
      return const SizedBox.shrink();
    }
    List<Widget> selectedAttributeWidgets = [];
    for (var attribute in attributes) {
      final selectedValueId =
          controller.selectedAttributes[attribute.skuPropertyId!];
      if (selectedValueId != null) {
        final matches =
            attribute.skuPropertyValues
                ?.where(
                  (value) =>
                      value.propertyValueId.toString() == selectedValueId,
                )
                .toList() ??
            [];
        final selectedValue = matches.isNotEmpty ? matches.first : null;
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: "https:${selectedValue.skuPropertyImagePath}",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }

          selectedAttributeWidgets.add(Wrap(children: rowChildren));
          selectedAttributeWidgets.add(const SizedBox(height: 8));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectedAttributeWidgets,
    );
  }
}
