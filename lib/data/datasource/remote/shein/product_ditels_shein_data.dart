import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class ProductDitelsSheinData {
  Crud crud;

  ProductDitelsSheinData(this.crud);

  getProductDitels(String goodssn, String countryCode) async {
    var response = await crud.getData(
      SheinApi.productDitels(goodssn, countryCode),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  getProductDitelsImageList(String goodssn, String countryCode) async {
    var response = await crud.getData(
      SheinApi.productDitelsImageList(goodssn, countryCode),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  getProductDitelsSize({
    required String goodsid,
    required String countryCode,
  }) async {
    var response = await crud.getData(
      SheinApi.productDitelsSize(goodsid, countryCode),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
