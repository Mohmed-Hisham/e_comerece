class AliaxpressApi {
  static const String server = "https://aliexpress-datahub.p.rapidapi.com";
  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'aliexpress-datahub.p.rapidapi.com',
<<<<<<< HEAD
    'X-RapidAPI-Key': '45cc5937a8msh845aaea38c15ddbp17dfaajsn8a6743f59232',
=======
    'X-RapidAPI-Key': '1bd0905b8fmshd7e930954808aeep1f3f99jsn4f9f6ee455a3',
>>>>>>> 911b6c07c4e18f884b5e8de3f7551d8c0f6b5a50
  };
  static String getcategory({required String lang}) {
    return "$server/category_list_1?locale=$lang";
  }

  static String hotProductsData({
    required int pageIndex,
    required String lang,
    required String kword,
  }) {
    return "$server/item_search_5?q=$kword&page=$pageIndex&sort=default&locale=$lang&region=YE&currency=USD";

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
    required int pageindex,
  }) {
    return "$server/item_search_5?q=$keyWord&page=$pageindex&sort=default&catId=$categoryId&locale=$lang&region=YE&currency=USD";
  }

  static String searshText({
    required String keyWord,
    required String lang,
    required int pageindex,
    String? categoryId,
  }) {
    return "$server/item_search_5?q=$keyWord&page=$pageindex&sort=default&catId=${categoryId ?? ""}&locale=$lang&region=YE&currency=USD";
    // return "$server/textsearch.php?keyWord=$keyWord&pageSize=150&pageIndex=$pageindex&country=YE&currency=USD&lang=$lang&filter=orders&sortBy=asc";
  }

  static String searshByimage({
    required String imageUrl,
    required String lang,
  }) {
    return "$server/item_search_image?sort=default&catId=0&imgUrl=$imageUrl&locale=$lang&region=YE&currency=USD";
  }
}
