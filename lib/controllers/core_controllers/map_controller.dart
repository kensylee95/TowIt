import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logistics_app/services/location_service.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapController extends GetxController {
  static MapController get instance => Get.find();
  final LocationService _locationService = Get.put(LocationService());
  final Rx<LocationData?> currentPosition = Rx(null);
  MapboxMap get mapBoxMap => _mapBoxMap;
  late MapboxMap _mapBoxMap;
  late Stream<LocationData> _currentPositionStream;
  final RxDouble cameraPosition = 13.0.obs;
  @override
  void onInit() async {
    currentPosition.value = await _locationService.currentPositionStream.first;
     _currentPositionStream = _locationService.currentPositionStream;
    super.onInit();
  }

  @override
  onReady() {
     currentPosition.bindStream(_currentPositionStream);
  }

  void onMapCreated(MapboxMap mapBoxMapArgs) {
    cameraPosition.value = 15;
    _mapBoxMap = mapBoxMapArgs;
    _mapBoxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingColor: 0xffff0000,
        pulsingEnabled: true,
        pulsingMaxRadius: 75,
      ),
    );
    _mapBoxMap.attribution.updateSettings(
      AttributionSettings(
        marginBottom: Get.height * 0.16,
        marginLeft: 0,
        clickable: false,
      ),
    );
    _mapBoxMap.scaleBar.updateSettings(
      ScaleBarSettings(
        enabled: false,
      ),
    );
    _mapBoxMap.easeTo(
        CameraOptions(
          zoom: cameraPosition.value,
          center: Point(
            coordinates: Position(currentPosition.value!.longitude!,
                currentPosition.value!.latitude!),
          ).toJson(),
        ),
        MapAnimationOptions(duration: 2000, startDelay: 0));

    //gestures
    _mapBoxMap.gestures.updateSettings(
      GesturesSettings(
        zoomAnimationAmount: 2,
        rotateEnabled: false,
      ),
    );
  }

  void changeCameraPosition(CameraChangedEventData eventData) {}
  void onMapScroll(ScreenCoordinate coordinate) {
    print(coordinate);
  }

  void onMapTap(ScreenCoordinate coordinate) {
  }

  @override
  void dispose() {
    _mapBoxMap.dispose();
    super.dispose();
  }
}
