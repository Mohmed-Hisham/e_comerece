import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class TrendaingSheinData {
  Crud crud;

  TrendaingSheinData(this.crud);

  getTrendingproduct() async {
    var response = await crud.getData(
      SheinApi.trendingProduct('4436', '1'),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
