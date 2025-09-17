import 'package:e_comerece/app_api/aliaxpress_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class SearchByImageData {
  Crud crud;

  SearchByImageData(this.crud);

  getData({required String imageUrl}) async {
    var response = await crud.getData(
      AliaxpressApi.searshByimage(imageUrl: imageUrl, lang: enOrAr()),
      headers: AliaxpressApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
