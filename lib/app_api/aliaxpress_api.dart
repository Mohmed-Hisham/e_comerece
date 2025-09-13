class AliaxpressApi {
  static const String server = "https://aliexpress-datahub.p.rapidapi.com";
  static String getcategory({required String lang}) {
    return "$server/category_list_1?locale=$lang";
  }

  static String hotProductsData({
    required int pageIndex,
    required String lang,
    required String Kword,
  }) {
    return "$server/item_search_5?q=$Kword&page=$pageIndex&sort=default&locale=$lang&region=YE&currency=USD";

    // /affiliate-hot-products.php?currency=USD&lang=$lang&country=YE&pageSize=50&pageIndex=$pageIndex";
  }

  static String itemDetails({required int productId, required String lang}) {
    return "$server/item_detail_6?itemId=$productId&currency=USD&region=YE&locale=$lang";

    // getproduct.php?&productId=$productId&currency=USD&country=YE&lang=$lang&welcomedeal=false";
  }

  static String shearchname({
    required String keyWord,
    required int categoryId,
    required String lang,
  }) {
    return "$server/item_search_5?q=$keyWord&page=1&sort=default&catId=$categoryId&locale=$lang&region=YE&currency=USD";
  }

  static String searshText({
    required String keyWord,
    required String lang,
    required int pageindex,
  }) {
    return "$server/item_search_5?q=$keyWord&page=$pageindex&sort=default&locale=$lang&region=YE&currency=USD";
    // return "$server/textsearch.php?keyWord=$keyWord&pageSize=150&pageIndex=$pageindex&country=YE&currency=USD&lang=$lang&filter=orders&sortBy=asc";
  }

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'aliexpress-datahub.p.rapidapi.com',
    'X-RapidAPI-Key': '3c0ab5688dmsh0817a4812cf01ddp13364djsn1d8e1391f7d3',
  };
}
