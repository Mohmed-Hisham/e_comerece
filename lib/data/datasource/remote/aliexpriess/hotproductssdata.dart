import 'package:e_comerece/app_api/aliaxpress_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class HotProductsData {
  Crud crud;

  HotProductsData(this.crud);

  getData(int pageIndex) async {
    var response = await crud.getData(
      AliaxpressApi.hotProductsData(
        Kword: "clothing",
        pageIndex: pageIndex,
        lang: enOrAr(),
      ),
      headers: AliaxpressApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
