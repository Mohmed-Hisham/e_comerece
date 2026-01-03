class SheinUrls {
  static const String _baseUrl =
      'https://sltukapis-production.up.railway.app/api/v1/Shein';

  static String categories(String lang) =>
      '$_baseUrl/categories?countryCode=$lang';

  static String trending(String lang, int pageIndex) =>
      '$_baseUrl/trending?Page=$pageIndex&CountryCode=$lang';

  //search by image
  static String search(
    String lang,
    String keyword,
    int pageIndex,
    String startPrice,
    String endPrice,
  ) =>
      '$_baseUrl/search?Keyword=$keyword&Page=$pageIndex&StartPrice=$startPrice&EndPrice=$endPrice&CountryCode=$lang';

  static String productDitels(String goodssn, String countryCode) =>
      "$_baseUrl/details/variants?GoodsSn=$goodssn&Country=$countryCode";

  static String productDitelsImageList(String goodssn, String countryCode) =>
      "$_baseUrl/details/images?GoodsSn=$goodssn&Country=$countryCode";

  static String productDitelsSize(String goodsid, String countryCode) =>
      "$_baseUrl/details/size?GoodsId=$goodsid&Country=$countryCode";

  static String productByCategories(
    String categoryId,
    String pageindex,
    String countryCode,
    String categoryName,
  ) =>
      "$_baseUrl/by-category?CategoryId=$categoryId&CategoryName=$categoryName&Page=$pageindex&CountryCode=$countryCode";
}
