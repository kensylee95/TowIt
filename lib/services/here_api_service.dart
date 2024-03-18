
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class HereApiService {
  
  final String apiKey = dotenv.env["HERE_API_TOKEN"]!;
  final String baseUrl = 'https://geocode.search.hereapi.com/v1/geocode';

 Future<Map<String, dynamic>> geocodeAddress(String address, [String? state]) async {
    const String countryFilter = 'countryCode:NGA'; // Filter addresses from Nigeria
    final String cityFilter = 'city:$state'; // Filter addresses within Abuja
    final String combinedFilter = state!=null ?'$countryFilter&$cityFilter':countryFilter;
    final Uri uri = Uri.parse('$baseUrl?q=$address&apiKey=$apiKey&in=$combinedFilter&limit=10');

   try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to geocode address: ${response.statusCode}');
      }
   } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
