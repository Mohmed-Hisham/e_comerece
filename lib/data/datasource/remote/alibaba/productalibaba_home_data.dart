import 'package:e_comerece/app_api/alibaba_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class ProductalibabaHomeData {
  Crud crud;

  ProductalibabaHomeData(this.crud);

  getproductHome({
    // required String q,
    required int pageindex,
    // required String lang,
  }) async {
    var response = await crud.getData(
      AlibabaApi.productHome(
        "clothes",
        pageindex,
        enOrAr(is_ar_SA: true),
        '',
        '',
      ),
      headers: AlibabaApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
