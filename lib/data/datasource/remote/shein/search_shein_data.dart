// import 'package:e_comerece/app_api/shein_api.dart';
// import 'package:e_comerece/core/class/crud.dart';

// class SearchSheinData {
//   Crud crud;

//   SearchSheinData(this.crud);

//   getsearch({
//     required String q,
//     required String pageindex,
//     required String startPrice,
//     required String endPrice,
//     required String countryCode,
//   }) async {
//     var response = await crud.getData(
//       SheinApi.searchproduct(q, pageindex, startPrice, endPrice, countryCode),
//       headers: SheinApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
