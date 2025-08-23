import 'package:e_comerece/app_api/aliaxpress_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class ProductDetailsData {
  Crud crud;

  ProductDetailsData(this.crud);

  getData(String productId) async {
    var response = await crud.getData(
      AliaxpressApi.itemDetails(productId: productId, lang: enOrAr()),
      headers: AliaxpressApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
