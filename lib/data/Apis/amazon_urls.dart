class AmazonUrls {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1/Amazon';

  static String categories(String lang) => '$_baseUrl/categories?Country=$lang';
  static String hotdeals(String lang) => '$_baseUrl/hot-deals?Lang=$lang';
  static String search(
    String lang,
    String keyword,
    int pageIndex,
    String startPrice,
    String endPrice,
  ) =>
      '$_baseUrl/search?Keyword=$keyword&PageIndex=$pageIndex&StartPrice=$startPrice&EndPrice=$endPrice&Lang=$lang';

  static String details(String lang, String productId) =>
      '$_baseUrl/product-details?Asin=$productId&Lang=$lang';
}
