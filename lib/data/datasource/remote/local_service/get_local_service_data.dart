// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/app_api/link_api.dart';

// class GetLocalService {
//   Crud crud;

//   GetLocalService(this.crud);

//   Future<dynamic> gtelocalService({int? page, int? pagesize}) async {
//     var response = await crud.postData(Appapi.getlocalService, {
//       if (page != null) "page": page,
//       if (pagesize != null) "pagesize": pagesize,
//     }, sendJson: false);

//     return response.fold((l) => l, (r) => r);
//   }
// }
