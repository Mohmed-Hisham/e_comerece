import 'package:e_comerece/app_api/amazon_api.dart';
import 'package:e_comerece/core/class/crud.dart';

class HotDealsAmazonData {
  Crud crud;
  HotDealsAmazonData(this.crud);

  getHotDeals(int offset) async {
    var response = await crud.getData(
      AmazonApi.hotdeals(offset: offset),
      headers: AmazonApi.rapidApiHeaders,
    );

    return response.fold((l) => l, (r) => r);
  }
}
