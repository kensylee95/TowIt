import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class MapBoxRepository {
  final String _accessToken = dotenv.env["MAPBOX_ACCESS_TOKEN"]!;
  //method to get suggested places name based on query string
  Future<List<Map<String, dynamic>>> getSuggestedPlaces(
      String query, LocationData currentPosition) async {
    const String country = "NG";
    final String uri =
        "https://api.mapbox.com/geocoding/v6/mapbox.places/${Uri.encodeComponent(query)}.json?access_token=$_accessToken&proximity=${currentPosition.longitude},${currentPosition.latitude}&country=$country";
    final Map<String, String> headers = {'content-type': 'application/json'};
    //list to store suggested places name
    List<Map<String, dynamic>> suggestedPlaces = [];
    //making an http request to the mapbox geocoding API
    var response = await http.get(Uri.parse(uri), headers: headers);
    //checking if the request is successful
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      //extracting the feature array containing place data
      List<dynamic> features = data["features"];
      //interating through each feature and extracting the place name and coordinates
      for (var feature in features) {
        String placeName = feature['place_name'];
        List<dynamic> coordinates = feature['geometry']['coordinates'];
        //adding place name and coordinates to the list of suggested places
        suggestedPlaces.add({
          'place_name': placeName,
          'coordinates': {
            'latitude': coordinates[1],
            'longitude': coordinates[0],
          }
        });
      }
    } else {
      //if the request failed, throw an exception
      throw (Exception("failed to fetch suggested places"));
    }
    //return list of suggested place names and coordinates
    return suggestedPlaces;
  }
}
