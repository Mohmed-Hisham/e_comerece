import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class ProductDitelsSheinData {
  Crud crud;

  ProductDitelsSheinData(this.crud);

  getProductDitels(String goodssn) async {
    var response = await crud.getData(
      SheinApi.productDitels(goodssn),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  getProductDitelsImageList(String goodssn) async {
    var response = await crud.getData(
      SheinApi.productDitelsImageList(goodssn),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  getProductDitelsSize({required String goodsid}) async {
    var response = await crud.getData(
      SheinApi.productDitelsSize(goodsid),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
