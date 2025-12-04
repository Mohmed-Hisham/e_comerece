import 'package:e_comerece/core/loacallization/translate_data.dart';

class SheinApi {
  static const String _server = "https://shein-data-api.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'shein-data-api.p.rapidapi.com',
    'X-RapidAPI-Key': 'a1b03d76bfmsh7765d1859618dd8p101be8jsn6ff2d5ccaf1f',
  };
  static String categories() =>
      "$_server/categories?countryCode=${enOrArShein()}";

  static String trendingProduct(
    String categoryId,
    String pageindex,
    String countryCode,
  ) =>
      "$_server/product/trending?categoryId=$categoryId&countryCode=$countryCode&page=$pageindex";

  static String searchproduct(
    String q,
    String pageindex,
    String startPrice,
    String endPrice,
    String countryCode,
  ) =>
      "$_server/search/v2?query=$q&page=$pageindex&perPage=120&minPrice=$startPrice&maxPrice=$endPrice&countryCode=$countryCode";

  static String productDitels(String goodssn, String countryCode) =>
      "$_server/product/description/variants?goods_sn=$goodssn&country=$countryCode";

  static String productDitelsImageList(String goodssn, String countryCode) =>
      "$_server/product/description/v3?goods_sn=$goodssn&country=$countryCode";

  static String productDitelsSize(String goodsid, String countryCode) =>
      "$_server/product/description/bygoodsid?goods_id=$goodsid&country=$countryCode";

  static String productByCategories(
    String categoryId,
    String pageindex,
    String countryCode,
  ) =>
      "$_server/product/bycategory?categoryId=$categoryId&page=$pageindex&perPage=120&countryCode=$countryCode";
}
