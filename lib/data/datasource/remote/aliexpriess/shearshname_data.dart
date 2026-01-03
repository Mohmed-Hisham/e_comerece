// import 'package:e_comerece/app_api/aliaxpress_api.dart';
// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/core/loacallization/translate_data.dart';

// class ShearshnameData {
//   Crud crud;

//   ShearshnameData(this.crud);

//   getData({
//     required String keyWord,
//     required int categoryId,
//     required int pageindex,
//   }) async {
//     var response = await crud.getData(
//       AliaxpressApi.shearchname(
//         keyWord: keyWord,
//         categoryId: categoryId,
//         lang: enOrAr(),
//         pageindex: pageindex,
//       ),
//       headers: AliaxpressApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
