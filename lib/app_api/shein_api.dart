class SheinApi {
  static const String _server = "https://shein-data-api.p.rapidapi.com";

  static const Map<String, String> rapidApiHeaders = {
    'X-RapidAPI-Host': 'shein-data-api.p.rapidapi.com',
    'X-RapidAPI-Key': '7a92b54596mshe98e59af65328ddp163ba0jsn2e4bbaa8dd83',
  };

  static String categories() {
    return "$_server/categories?countryCode=YE";
  }
}
