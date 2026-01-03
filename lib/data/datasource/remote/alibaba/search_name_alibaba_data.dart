// import 'package:e_comerece/app_api/alibaba_api.dart';
// import 'package:e_comerece/core/class/crud.dart';

// class SearchNameAlibabaData {
//   Crud crud;

//   SearchNameAlibabaData(this.crud);

//   getproductsSearch({
//     required String q,
//     required int pageindex,
//     required String lang,
//     String startPrice = '',
//     String endPrice = '',
//   }) async {
//     var response = await crud.getData(
//       AlibabaApi.productHome(q, pageindex, lang, endPrice, startPrice),
//       headers: AlibabaApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
