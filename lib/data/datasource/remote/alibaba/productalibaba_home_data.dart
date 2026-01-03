// import 'package:e_comerece/app_api/alibaba_api.dart';
// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/core/loacallization/translate_data.dart';

// class ProductalibabaHomeData {
//   Crud crud;

//   ProductalibabaHomeData(this.crud);

//   getproductHome({
//     // required String q,
//     required int pageindex,
//     // required String lang,
//   }) async {
//     var response = await crud.getData(
//       AlibabaApi.productHome(
//         "fashion",
//         pageindex,
//         enOrAr(isArSA: true),
//         '',
//         '',
//       ),
//       headers: AlibabaApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
