class AlibabaApi {
  static const String _server = "https://alibaba-datahub.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'alibaba-datahub.p.rapidapi.com',
    'X-RapidAPI-Key': '154f05712emsh78a06e9450717a1p10be2cjsn534236a10e6a',
  };

  static String productHome(
    String q,
    int pageindex,
    String lang,
    String endPrice,
    String startPrice,
  ) {
    return "$_server/item_search?q=$q&page=$pageindex&endPrice=$endPrice&startPrice=$startPrice&&pageSize=100&region=YE&currency=USD&locale=$lang";
  }

  static String searshByimage({
    required String imageUrl,
    required String lang,
    required int pageindex,
  }) {
    return "$_server/item_search_image?imgUrl=$imageUrl&page=$pageindex&pageSize=100&region=YE&currency=USD&locale=$lang";
  }

  static String itemDetails({required int productId, required String lang}) {
    return "$_server/item_detail?itemId=$productId&currency=USD&locale=$lang";
  }
}
