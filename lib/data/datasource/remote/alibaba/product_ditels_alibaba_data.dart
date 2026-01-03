// import 'package:e_comerece/app_api/alibaba_api.dart';
// import 'package:e_comerece/core/class/crud.dart';

// class ProductDitelsAlibabaData {
//   Crud crud;

//   ProductDitelsAlibabaData(this.crud);

//   getData(int productId, String lang) async {
//     var response = await crud.getData(
//       AlibabaApi.itemDetails(productId: productId, lang: lang),
//       headers: AlibabaApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
