import 'package:e_comerece/core/class/api_service.dart';

class MapPlacesServiese {
  ApiService apiService;

  MapPlacesServiese(this.apiService);
  static const String _apiKey = "AIzaSyAdOeHEcFmucmNlUK4t8qyImM7C2U4ABLw";

  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  Future<Map<String, dynamic>?> fetchPredictions(
    String input,
    String sessionToken,
  ) async {
    try {
      var response = await apiService.get(
        endpoint:
            "$_baseUrl?input=$input&key=$_apiKey&sessionToken=$sessionToken",
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getPlaceDetails(
    String placeId,
    String sessionToken,
  ) async {
    try {
      var response = await apiService.get(
        endpoint:
            "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey&sessionToken=$sessionToken",
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
