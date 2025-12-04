import 'package:e_comerece/app_api/aliaxpress_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';

class CategoryData {
  Crud crud;

  CategoryData(this.crud);

  getData() async {
    var response = await crud.getData(
      AliaxpressApi.getcategory(lang: enOrAr()),
      headers: AliaxpressApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
