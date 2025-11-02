class SheinApi {
  static const String _server = "https://shein-data-api.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'shein-data-api.p.rapidapi.com',
    'X-RapidAPI-Key': '1cdedf81b2msh9d2cbbf21b03409p1fc930jsn9c27cf0b5142',
  };

  static String categories() {
    return "$_server/categories?countryCode=SA";
  }

  static String trendingProduct(String categoryId, String pageindex) {
    return "$_server/product/trending?categoryId=$categoryId&countryCode=YE&page=$pageindex";
  }

  static String searchproduct(
    String q,
    String pageindex,
    String startPrice,
    String endPrice,
  ) {
    return "$_server/search/v2?query=$q&page=$pageindex&perPage=120&minPrice=$startPrice&maxPrice=$endPrice&countryCode=YE";
  }

  static String productDitels(String goodssn) {
    return "$_server/product/description/variants?goods_sn=$goodssn&country=YE";
  }

  static String productDitelsImageList(String goodssn) {
    return "$_server/product/description/v3?goods_sn=$goodssn&country=YE";
  }

  static String productDitelsSize(String goodsid) {
    return "$_server/product/description/bygoodsid?goods_id=$goodsid&country=YE";
  }

  static String productByCategories(String categoryId, String pageindex) {
    return "$_server/product/bycategory?categoryId=$categoryId&page=$pageindex&perPage=120&countryCode=YE";
  }
}
