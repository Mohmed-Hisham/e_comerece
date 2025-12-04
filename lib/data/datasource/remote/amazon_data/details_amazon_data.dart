import 'package:e_comerece/app_api/amazon_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class DetailsAmazonData {
  Crud crud;
  DetailsAmazonData(this.crud);

  getDetails({required String asin, required String lang}) async {
    var response = await crud.getData(
      AmazonApi.productDitels(asin, lang),
      headers: AmazonApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
