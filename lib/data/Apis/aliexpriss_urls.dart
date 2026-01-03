class AliexprissUrls {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1/AliExpress';

  static String categories(String lang) => '$_baseUrl/category?lang=$lang';
  static String hotProducts(String lang, int pageIndex, String keyword) =>
      '$_baseUrl/hot-products?PageIndex=$pageIndex&Keyword=$keyword&Lang=$lang';
  static String searchByImage(String lang, String imageUrl) =>
      '$_baseUrl/search/image?ImageUrl=$imageUrl&Lang=$lang';
  static String search(
    String lang,
    String keyword,
    int pageIndex,
    int categoryId,
  ) =>
      '$_baseUrl/search?Keyword=$keyword&PageIndex=$pageIndex&CategoryId=$categoryId&Lang=$lang';

  static String details(String lang, int productId) =>
      '$_baseUrl/item-details?ProductId=$productId&Lang=$lang';
}
