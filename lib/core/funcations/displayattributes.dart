import 'package:e_comerece/controller/aliexpriess/product_details_controller.dart';

Map<String, Map<String, String?>> buildDisplayAttributes(
  ProductDetailsController controller,
) {
  final Map<String, Map<String, String?>> displayAttributes = {};

  controller.selectedAttributes.forEach((attributeId, valueId) {
    final attribute = controller
        .itemDetails
        ?.skuComponent
        ?.productSKUPropertyList
        ?.firstWhere((attr) => attr.skuPropertyId == attributeId);

    final value = attribute?.skuPropertyValues?.firstWhere(
      (val) => val.propertyValueId.toString() == valueId,
    );

    if (attribute != null && value != null) {
      displayAttributes[attribute.skuPropertyName!] = {
        'name': value.propertyValueDisplayName,
        'image': value.skuPropertyImagePath,
      };
    }
  });

  return displayAttributes;
}
