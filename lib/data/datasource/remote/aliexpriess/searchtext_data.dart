// import 'package:e_comerece/app_api/aliaxpress_api.dart';
// import 'package:e_comerece/core/class/crud.dart';

// class SearchtextData {
//   Crud crud;

//   SearchtextData(this.crud);

//   getData({
//     required String keyWord,
//     required int pageindex,
//     required String lang,
//     String? categoryId,
//   }) async {
//     var response = await crud.getData(
//       AliaxpressApi.searshText(
//         keyWord: keyWord,
//         pageindex: pageindex,
//         lang: lang,
//         categoryId: categoryId,

//         //  enOrAr(),
//       ),
//       headers: AliaxpressApi.rapidApiHeaders,
//       debug: true,
//     );

//     return response.fold((l) => l, (r) => r);
//   }
// }
