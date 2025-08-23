class AliaxpressApi {
  static const String server = "https://aliexpress-business-api.p.rapidapi.com";
  static String getcategory({required String lang}) {
    return "$server/getcategory.php?lang=$lang";
  }

  static String hotProductsData({
    required int pageIndex,
    required String lang,
  }) {
    return "$server/affiliate-hot-products.php?currency=USD&lang=$lang&country=YE&pageSize=50&pageIndex=$pageIndex";
  }

  static String itemDetails({required String productId, required String lang}) {
    return "$server/getproduct.php?&productId=$productId&currency=USD&country=YE&lang=$lang&welcomedeal=false";
  }
  //

  static String shearchname({
    required String keyWord,
    required int categoryId,
    required String lang,
  }) {
    return "$server/textsearch.php?keyWord=$keyWord&pageSize=62&pageIndex=1&country=YE&currency=USD&lang=$lang&filter=orders&sortBy=asc&categoryId=$categoryId";
  }

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'aliexpress-business-api.p.rapidapi.com',
    'X-RapidAPI-Key': '0829484c86msh154e3f518c6c4a4p10e50cjsn0b81e9a6ea84',
  };
}
