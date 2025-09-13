import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';

// >> الدالة الآن تُرجع Map أكثر تعقيداً <<
Map<String, Map<String, String?>> buildDisplayAttributes(
  ProductDetailsController controller,
) {
  final Map<String, Map<String, String?>> displayAttributes = {};

  controller.selectedAttributes.forEach((attributeId, valueId) {
    try {
      final attribute = controller.uiSkuProperties
          .firstWhere((attr) => attr.skuPropertyId == attributeId);

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
      print("Error building display attributes for attrID $attributeId: $e");
    }
  });

  return displayAttributes;
}
