
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService extends GetxController{
 static LocationService get instance => LocationService();
 LocationData? get currentPosition  =>  _locationPosition;
  Stream<LocationData> get currentPositionStream => _onLocationDataChanged();
 final _location = Location();
 LocationData? _locationPosition;
 @override
  void onInit()async{
  _locationPosition = await _locationData();
  _location.changeSettings(accuracy: LocationAccuracy.navigation);
   super.onInit();
 }
  Future<LocationData> _locationData()async{
   final LocationData cord = await _location.getLocation();
    return cord;
  }

Stream<LocationData> _onLocationDataChanged(){
final Stream<LocationData> listenable = _location.onLocationChanged;
return listenable;
}

}