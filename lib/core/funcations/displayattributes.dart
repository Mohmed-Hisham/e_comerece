import 'dart:developer';

import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';

Map<String, Map<String, String?>> buildDisplayAttributes(
  Map<String, String> selectedAttributes,
  List<ProductSKUPropertyList> uiSkuProperties,
) {
  final Map<String, Map<String, String?>> displayAttributes = {};

  selectedAttributes.forEach((attributeId, valueId) {
    try {
      final attribute = uiSkuProperties.firstWhere(
        (attr) => attr.skuPropertyId == attributeId,
      );

      final value = attribute.skuPropertyValues?.firstWhere(
        (val) => val.propertyValueId.toString() == valueId,
      );

      if (value != null && attribute.skuPropertyName != null) {
        displayAttributes[attribute.skuPropertyName!] = {
          'name': value.propertyValueDisplayName,
          'image':
              (value.skuPropertyImagePath != null &&
                  value.skuPropertyImagePath!.isNotEmpty)
              ? value.skuPropertyImagePath
              : null,
        };
      }
    } catch (e) {
      log("Error building display attributes for attrID $attributeId: $e");
    }
  });

  return displayAttributes;
}
