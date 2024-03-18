
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/controllers/core_controllers/map_controller.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapBoxDisplayWidget extends StatelessWidget {
  const MapBoxDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MapController controller = Get.put(MapController());
      return Obx(
      () => controller.currentPosition.value != null
          ?  MapWidget(
              onTapListener: controller.onMapTap,
              mapOptions: MapOptions(
                pixelRatio: 1.3,
                contextMode: ContextMode.UNIQUE,
               
              ),
              cameraOptions: CameraOptions(
                zoom: controller.cameraPosition.value,
                center: Point(
                  coordinates: Position(
                      controller.currentPosition.value!.longitude!,
                      controller.currentPosition.value!.latitude!),
                ).toJson(),
              ),
              styleUri: "mapbox://styles/chur/clti9z8ec006a01pj4y8ncj1z",
              onMapCreated: (mapBoxMapArgs) {
                controller.onMapCreated(mapBoxMapArgs);
              },
          
            ):const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
