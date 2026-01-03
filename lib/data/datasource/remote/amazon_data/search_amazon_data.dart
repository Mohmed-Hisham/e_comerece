// import 'package:e_comerece/app_api/amazon_api.dart';
// import 'package:e_comerece/core/class/crud.dart';

// class SearchAmazonData {
//   Crud crud;
//   SearchAmazonData(this.crud);

//   getSearch({
//     required String q,
//     required int pageindex,
//     required int startPrice,
//     required int endPrice,
//     required String lang,
//   }) async {
//     var response = await crud.getData(
//       AmazonApi.searshProduct(q, pageindex, startPrice, endPrice, lang),
//       headers: AmazonApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
