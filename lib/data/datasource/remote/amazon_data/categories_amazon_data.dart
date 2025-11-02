import 'package:e_comerece/app_api/amazon_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class CategoriesAmazonData {
  Crud crud;
  CategoriesAmazonData(this.crud);

  getCategories() async {
    var response = await crud.getData(
      AmazonApi.categories(),
      headers: AmazonApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
