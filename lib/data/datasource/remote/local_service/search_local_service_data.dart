import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/app_api/link_api.dart';

class SearchLocalService {
  Crud crud;

  SearchLocalService(this.crud);

  Future<dynamic> getSearchLocalService({required String search}) async {
    var response = await crud.postData(Appapi.searchlocalService, {
      "search": search,
    });

    return response.fold((l) => l, (r) => r);
  }
}
