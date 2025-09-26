import 'package:e_comerece/data/model/alibaba_model/product_ditels_alibaba_model.dart';

Map<String, Map<String, String?>> selectedAttributesToMapForDb(
  Map<String, Value> selectedAttributes,
) {
  final Map<String, Map<String, String?>> out = {};

  selectedAttributes.forEach((propKey, val) {
    out[propKey] = {'id': val.id, 'name': val.name, 'image': val.image ?? ''};
  });

  return out;
}

List<Map<String, String?>> priceListToMap(List<PriceList> priceList) {
  List<Map<String, String?>> out = [];

  for (var p in priceList) {
    out.add({
      'price': p.price.toString(),
      'formatprice': p.priceFormatted.toString(),
      'maxquantity': p.maxQuantity.toString(),
      'minquantity': p.minQuantity.toString(),
    });
  }

  return out;
}
