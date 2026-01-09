// import 'dart:developer';

// import 'package:e_comerece/core/class/crud.dart';
// import 'package:e_comerece/app_api/link_api.dart';

// class AddServiceRequestData {
//   Crud crud;

//   AddServiceRequestData(this.crud);

//   Future<dynamic> addServiceRequest(
//     int userid,
//     int serviceid,
//     String note,
//     int addressid,
//     double quotedPrice,
//     String status,
//   ) async {
//     var response = await crud.postData(Appapi.addlocalService, {
//       "userid": userid,
//       "serviceid": serviceid,
//       "note": note,
//       "addressid": addressid,
//       "status": status,
//       "quoted_price": quotedPrice,
//     });
//     log("response $response");

//     return response.fold((l) => l, (r) => r);
//   }
// }
