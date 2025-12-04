import 'package:e_comerece/app_api/shein_api.dart';
import 'package:e_comerece/core/class/crud.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';

class TrendaingSheinData {
  Crud crud;

  TrendaingSheinData(this.crud);

  getTrendingproduct(int page) async {
    var response = await crud.getData(
      SheinApi.trendingProduct('4436', page.toString(), enOrArShein()),
      headers: SheinApi.rapidApiHeaders,
      debug: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
