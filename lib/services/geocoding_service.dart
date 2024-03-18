import 'package:geocoding/geocoding.dart';
class GeoCodingService{
 Future<List<Placemark>> locationFromCod( double latitude, double longitude)async{
  List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
  placeMarks.sort((a,b)=>a.thoroughfare==null?-1:1);
  return placeMarks;
  }
  Future<List<Location>> locationFromString( String address)async{
  List<Location> placeMarks = await locationFromAddress(address);
  return placeMarks;
  }
}