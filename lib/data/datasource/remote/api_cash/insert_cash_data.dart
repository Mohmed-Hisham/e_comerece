import 'dart:convert';
import 'dart:developer';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class InsertCashData {
  Crud crud;

  InsertCashData(this.crud);

  insertCash({
    required String query,
    required String platform,
    required dynamic data,
    String ttlHours = "24",
  }) async {
    var response = await crud.postData(Appapi.insertCash, {
      "query": query,
      "platform": platform,
      "data": jsonEncode(data),
      "ttlHours": ttlHours,
    });

    log("Insert Cash Response: $response");

    return response.fold((l) => l, (r) => r);
  }
}
