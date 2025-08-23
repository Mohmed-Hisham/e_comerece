import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';
import 'package:flutter/material.dart';

class CustattributeSelection extends StatelessWidget {
  final ProductDetailsController controller;

  const CustattributeSelection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final attributes =
        controller.itemDetails?.skuComponent?.productSKUPropertyList;
    if (attributes == null || attributes.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributes.map((attribute) {
        print(attribute.skuPropertyName);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attribute.skuPropertyName ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: attribute.skuPropertyValues!.map((value) {
                final isSelected =
                    controller.selectedAttributes[attribute.skuPropertyId!] ==
                    value.propertyValueId!.toString();
                return GestureDetector(
                  onTap: () {
                    print(value.propertyValueDisplayName!.toString());
                    controller.updateSelectedAttribute(
                      attribute.skuPropertyId!,
                      value.propertyValueId!.toString(),
                    );
                  },
                  child: Column(
                    children: [
                      Text(value.propertyValueDisplayName!.toString()),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.red : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            (value.skuPropertyImagePath != null &&
                                value.skuPropertyImagePath!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: value.skuPropertyImagePath!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Text(
                                  value.propertyValueDisplayName ?? '',
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}
