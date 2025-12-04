class AmazonApi {
  static const String _server = "https://real-time-amazon-data.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'real-time-amazon-data.p.rapidapi.com',
    'X-RapidAPI-Key': '1bd0905b8fmshd7e930954808aeep1f3f99jsn4f9f6ee455a3',
  };

  static String categories({required String countryForLanguage}) {
    return "$_server/product-category-list?country=$countryForLanguage";
  }

  static String hotdeals({int offset = 0, required String lang}) {
    return "$_server/deals-v2?country=SA&offset=$offset&min_product_star_rating=ALL&price_range=ALL&discount_range=ALL&language=$lang";
  }

  static String searshProduct(
    String q,
    int pageindex,
    int startPrice,
    int endPrice,
    String lang,
  ) {
    return "$_server/search?query=$q&page=$pageindex&country=SA&sort_by=RELEVANCE&min_price=$startPrice&max_price=$endPrice&product_condition=ALL&is_prime=false&deals_and_discounts=NONE&language=$lang";
  }

  static String productDitels(String asin, String lang) {
    return "$_server/product-details?asin=$asin&country=SA&language=$lang";
  }
}
