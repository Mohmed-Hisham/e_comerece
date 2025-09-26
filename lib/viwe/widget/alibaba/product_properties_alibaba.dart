import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class ProductPropertiesAlibaba extends StatelessWidget {
  final ProductDetailsAlibabaControllerImple controller;
  const ProductPropertiesAlibaba({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final properties = controller.getProductProperties();
    if (properties.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Details',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: properties.map((property) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        property.name ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Appcolor.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Text(
                        property.value ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Appcolor.black2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
