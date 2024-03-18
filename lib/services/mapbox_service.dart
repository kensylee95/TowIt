import 'package:location/location.dart';
import 'package:logistics_app/repositories/mapbox_repositoy.dart';

class MapBoxService {
  
  final MapBoxRepository _mapboxRepository = MapBoxRepository();

  Future<List<Map<String, dynamic>>> getSuggestedPlaces(String query, LocationData currentPosition)async{
  final List<Map<String, dynamic>> suggestedPlaces = await _mapboxRepository.getSuggestedPlaces(query, currentPosition);
   return suggestedPlaces;
  }


}
