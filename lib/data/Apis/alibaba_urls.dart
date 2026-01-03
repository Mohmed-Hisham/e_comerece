class AlibabaUrls {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1/Alibaba';

  static String hotProducts(
    String lang,
    int pageIndex,
    String keyword,
    String startPrice,
    String endPrice,
    String catId,
  ) =>
      '$_baseUrl/search?Keyword=$keyword&PageIndex=$pageIndex&StartPrice=$startPrice&EndPrice=$endPrice&CategoryId=$catId&Lang=$lang';

  //search by image
  static String searchByImage(String lang, String imageUrl, int pageIndex) =>
      '$_baseUrl/search-image?PageIndex=$pageIndex&Lang=$lang&ImageUrl=$imageUrl';

  //details
  static String details(String lang, String productId) =>
      '$_baseUrl/item-details?ProductId=$productId&Lang=$lang';
}
