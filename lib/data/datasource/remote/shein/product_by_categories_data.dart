import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class ProductByCategoriesData {
  Crud crud;
  ProductByCategoriesData(this.crud);

  getproductbycategories({
    required String categoryId,
    required String pageindex,
    required String countryCode,
  }) async {
    var response = await crud.getData(
      SheinApi.productByCategories(categoryId, pageindex, countryCode),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
