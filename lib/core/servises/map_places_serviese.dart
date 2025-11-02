import 'package:e_comerece/core/class/crud.dart';

class MapPlacesServiese {
  Crud crud;

  MapPlacesServiese(this.crud);
  static const String _apiKey = "AIzaSyAdOeHEcFmucmNlUK4t8qyImM7C2U4ABLw";

  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  fetchPredictions(String input, String sessionToken) async {
    var response = await crud.getData(
      "$_baseUrl?input=$input&key=$_apiKey&sessionToken=$sessionToken",
    );

    return response.fold((l) => l, (r) => r);
  }

  getPlaceDetails(String placeId) async {
    var response = await crud.getData(
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey",
    );

    return response.fold((l) => l, (r) => r);
  }
}
