class SheinApi {
  static const String _server = "https://shein-data-api.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'shein-data-api.p.rapidapi.com',
    'X-RapidAPI-Key': '1bd0905b8fmshd7e930954808aeep1f3f99jsn4f9f6ee455a3',
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
    return "$_server/product/description/v3?goods_sn=$goodssn&country=SAR";
  }

  static String productDitelsSize(String goodsid) {
    return "$_server/product/description/bygoodsid?goods_id=$goodsid&country=SAR";
  }

  static String productByCategories(String categoryId, String pageindex) {
    return "$_server/product/bycategory?categoryId=$categoryId&page=$pageindex&perPage=120&countryCode=YE";
  }
}
