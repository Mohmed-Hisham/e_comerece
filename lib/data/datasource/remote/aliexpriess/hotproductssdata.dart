// import 'package:e_comerece/app_api/aliaxpress_api.dart';
// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/core/loacallization/translate_data.dart';

// class HotProductsData {
//   Crud crud;

//   HotProductsData(this.crud);

//   getData(int pageIndex, {String? q}) async {
//     var response = await crud.getData(
//       AliaxpressApi.hotProductsData(
//         kword: q ?? "women fashion ",
//         pageIndex: pageIndex,
//         lang: enOrAr(),
//       ),
//       headers: AliaxpressApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
