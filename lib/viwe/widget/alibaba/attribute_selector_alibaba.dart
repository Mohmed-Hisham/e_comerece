import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/alibaba/product_details_alibaba_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/shared/widget_shared/open_full_image.dart';
import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';
import 'package:flutter/material.dart';

class AttributeSelectorAlibaba extends StatelessWidget {
  final ProductDetailsAlibabaControllerImple controller;
  final Prop prop;
  final String? text;
  const AttributeSelectorAlibaba({
    super.key,
    required this.controller,
    required this.prop,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            text: prop.name ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
            children: [
              TextSpan(
                text: "  $text",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Appcolor.primrycolor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: prop.values.map<Widget>((value) {
            final isSelected = controller.isAttributeSelected(
              prop.name ?? '',
              value,
            );

            return InkWell(
              onDoubleTap: () {
                openFullImage(context, 'https:${value.image}');
              },
              onTap: () {
                controller.updateSelectedAttribute(prop.name ?? '', value);
                controller.getCartItemInfo();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Appcolor.primrycolor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Appcolor.primrycolor : Appcolor.gray,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value.image != null && value.image!.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: value.image!.startsWith('//')
                              ? 'https:${value.image}'
                              : value.image!,
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      value.name ?? '',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Appcolor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
