import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class CategoriesSheinData {
  Crud crud;

  CategoriesSheinData(this.crud);

  getCategories() async {
    var response = await crud.getData(
      SheinApi.categories(),
      headers: SheinApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
