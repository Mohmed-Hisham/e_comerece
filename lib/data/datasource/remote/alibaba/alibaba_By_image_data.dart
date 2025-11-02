import 'package:e_comerece/app_api/alibaba_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';

class AlibabaByImageData {
  Crud crud;

  AlibabaByImageData(this.crud);

  getDataByimage({required String imageUrl, required int pageindex}) async {
    var response = await crud.getData(
      AlibabaApi.searshByimage(
        imageUrl: imageUrl,
        lang: enOrAr(is_ar_SA: true),
        pageindex: pageindex,
      ),
      headers: AlibabaApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
