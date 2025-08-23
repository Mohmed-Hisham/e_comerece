import 'package:e_comerece/app_api/aliaxpress_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class ShearshnameData {
  Crud crud;

  ShearshnameData(this.crud);

  getData({required String keyWord, required int categoryId}) async {
    var response = await crud.getData(
      AliaxpressApi.shearchname(
        keyWord: keyWord,
        categoryId: categoryId,
        lang: enOrAr(),
      ),
      headers: AliaxpressApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
