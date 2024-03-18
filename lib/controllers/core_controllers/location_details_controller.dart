import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logistics_app/controllers/Animations/tween_animation.dart';
import 'package:logistics_app/models/geo_location_model.dart';
import 'package:logistics_app/services/geocoding_service.dart';
import 'package:logistics_app/services/here_api_service.dart';
import 'package:logistics_app/services/location_service.dart';
import 'package:logistics_app/services/mapbox_service.dart';
//import 'package:mapbox_search/mapbox_search.dart';
import 'package:pinput/pinput.dart';

class LocationDetailsController extends GetxController {
  static LocationDetailsController get instance => Get.find();
  //TweenAnimation class
  TweenAnimation tweenAnimation = Get.put(TweenAnimation());
  final positionedOffset = 0.0.obs;
  //scroll controller of bottomsheet
  final Rx<ScrollController> scrollController =
      Rx<ScrollController>(ScrollController());
  //drag distance used to animate bottom sheet when user drags screen vertically
  final dragDistance = 0.0.obs;
  //holds double type value for animating top smaller container as bottom sheet drag distance changes
  final RxDouble positionedBottomSheetHeight = RxDouble(0.0);
  //boolean to know when bottom sheet is expanded
  RxBool isBottomSheetExpanded = false.obs;
  //initial size of the DraggableScrollableSheet
  double initialBottomSheetSize = 0.15;
  //max size of bottomsheet (DraggableScrollableSheet)
  double maxBottomSheetSize = 1;
  //holds the animation for bottomsheet
  late Rx<Animation<double>> _largerBottomSheetAnim;
  //percent width of screen i.e 0.25 of screen for the smaller container
  double smallerBottomsheetHeight = 0.27;
  //holds the animation for the small top container
  late Rx<Animation<double>> _smallerBottomsheetAnim;
  //calc smaller container height
  late double? _smallBtmsheetCalcHeight;
  //----------------Location Data--------------------
  final TextEditingController pickUpLocation = TextEditingController();
  final TextEditingController destination = TextEditingController();
  //observable to hold destination textediting controller value
  final destinationText = "".obs;
  final FocusNode destinationFieldfocusNode = FocusNode();
  final destinationFieldHasFocus = false.obs;
  final FocusNode pickUpFieldfocusNode = FocusNode();
  final pickUpFieldHasfocus = false.obs;
  //current location coordinates
  Rx<LocationData?> currentPosition = Rx(null);
  //get instance of our location service class
  final LocationService _locationService = Get.put(LocationService());
  //Get our instance of mapBoxService class
  final MapBoxService _mapBoxService = MapBoxService();
  //Get instance of our geoCodingService class
  final GeoCodingService _geoCodingService = GeoCodingService();
  //device height of client device
  final double _deviceHeight = Get.height;
  final List<GeoLocationModel> geoLocationModel = [];
  final isLoadingLocations = false.obs;
  @override
  void onInit() async {
//animations for gestures during screen drag onInit
    _onInit();
    //listener for destination textfield focusNode
    destinationFieldfocusNode.addListener(() {
      destinationFieldHasFocus.value = destinationFieldfocusNode.hasFocus;
    });
    //listener for pickUpTextfield focusNode
    pickUpFieldfocusNode.addListener(() {
      pickUpFieldHasfocus.value = pickUpFieldfocusNode.hasFocus;
    });
    //location stream to get user latitude and longitude coordinates
    Stream<LocationData> locationPositionStream =
        _locationService.currentPositionStream;
    //binds stream to currentPosition (so that every time we receive stream currentPosition is updated
    // with locationData)

    currentPosition.bindStream(locationPositionStream);
    //set the initial value for current Position
    currentPosition.value = await locationPositionStream.first;
    //listener destination textfield  TextEditingController(if editingController changes)
    destination.addListener(() {
      destinationText.value = destination.value.text.trim();
    });
    //worker to delay the call of findLocationSuggestions method every time the destinationText changes
    //i.e as user types we delay the call to our method for say 700ms
    //detinationText is an Rx observable that contains the destination TextEditingController value
    debounce(
      destinationText,
      (placeName) => findLocationSuggestions(placeName, currentPosition.value!),
      time: const Duration(milliseconds: 700),
    );
    //set pickuplocation textfield with the current address
    _setUserLocation(currentPosition.value!);

    super.onInit();
  }

  void _onInit() {
    _smallBtmsheetCalcHeight = _deviceHeight * smallerBottomsheetHeight;
    //initiating value for drag distance
    dragDistance.value = initialBottomSheetSize;
    const double smallerBottomsheetInitialHeight = 0;
    //Get.height * smallerBottomsheetHeight;
    //small container animation value
    _smallerBottomsheetAnim = Rx<Animation<double>>(tweenAnimation.animation(
        Tween(
            begin: smallerBottomsheetInitialHeight,
            end: -_smallBtmsheetCalcHeight!)));
    //DraggableScrollableSheet controller animation
    _largerBottomSheetAnim = Rx<Animation<double>>(tweenAnimation.animation(
        Tween(begin: smallerBottomsheetHeight, end: initialBottomSheetSize)));
    tweenAnimation.animationController.addListener(
      () => _updatePositionedBottomSheetHeight(),
    );
  }

  @override
  void onReady() async {
    //##---------------Animations
    //duration for animation controller on start
    tweenAnimation.animationController.duration =
        const Duration(milliseconds: 600);
    tweenAnimation.startAnimation();
    //change duration for subsequent animations using this controller
    tweenAnimation.animationController.duration =
        const Duration(milliseconds: 300);
    super.onReady();
  }

//method to get location suggestions as user types
  findLocationSuggestions(
      String placeName, LocationData currentPosition) async {
    isLoadingLocations.value = true;

    try {
      //for MapBox
      /* final List<Map<String, dynamic>> places =
        await _mapBoxService.getSuggestedPlaces(placeName, currentPosition);
    print(currentPosition);
    print(places);
  */
      //for Here API
      final HereApiService hereApiService = HereApiService();
      final List<geocoding.Placemark> locationFromCod =
          await _geoCodingService.locationFromCod(
              currentPosition.latitude!, currentPosition.longitude!);
      isLoadingLocations.value = false;
      final Map<String, dynamic> places = await hereApiService.geocodeAddress(
          placeName, locationFromCod[0].locality);
      List<dynamic> placesData = places["items"];
      List<GeoLocationModel> geoData = placesData.isEmpty
          ? []
          : placesData.map((location) {
              return GeoLocationModel(
                  address: location["address"]["label"],
                  city: location["address"]["city"],
                  latitude: location["position"]["lat"],
                  longitude: location["position"]["lng"],
                  country: location["address"]["countryName"]);
            }).toList();
      geoLocationModel.assignAll(geoData);
      //print(placesData[0]["address"]["label"]);
    } catch (e) {
      isLoadingLocations.value = false;
      Get.snackbar("Network Error",
          "An error occured while proccessing your request, try again.");
    }
  }

//--------------------## Animations-------------------
  //Listener call back when animation happens
  void _updatePositionedBottomSheetHeight() {
    //update observables used by UI so that animation is reflected in UI
    positionedBottomSheetHeight.value = _smallerBottomsheetAnim.value.value;
    dragDistance.value = _largerBottomSheetAnim.value.value;
  }

  updatePositionedOffset({required double height}) {
    positionedOffset.value =
        (scrollController.value.position.viewportDimension -
                scrollController.value.offset) /
            2;
  }

  void _setUserLocation(LocationData currentPosition) async {
    List<geocoding.Placemark> locationNames = await _geoCodingService
        .locationFromCod(currentPosition.latitude!, currentPosition.longitude!);
    // print(locationNames);
    pickUpLocation.setText(locationNames[0].thoroughfare ?? "");
  }

  //Animate when onClose button is tapped
  animateOnClose() {
    if (pickUpLocation.value.text.isEmpty) {
      Future.delayed(const Duration(milliseconds: 300),
          () => _setUserLocation(currentPosition.value!));
    }
    _smallerBottomsheetAnim.value = tweenAnimation.animation(Tween(
        begin: smallerBottomsheetHeight, end: -_smallBtmsheetCalcHeight!));
    _largerBottomSheetAnim.value = tweenAnimation.animation(
        Tween(begin: maxBottomSheetSize, end: initialBottomSheetSize));
    tweenAnimation.startAnimation(from: 0);
    destinationFieldfocusNode.unfocus();
  }

  //reverse back animation when "from where?" widget is tapped
  void animateOnTap() {
    _smallerBottomsheetAnim.value = tweenAnimation.animation(Tween(
        begin: smallerBottomsheetHeight, end: -_smallBtmsheetCalcHeight!));
    _largerBottomSheetAnim.value = tweenAnimation.animation(
        Tween(begin: maxBottomSheetSize, end: initialBottomSheetSize));
    tweenAnimation.animationController.reverse();
    //delay for 300 miliseconds before focusing destination textfield
    Future.delayed(
      const Duration(milliseconds: 400),
      () => Get.focusScope!.requestFocus(destinationFieldfocusNode),
    );
  }

  //called during dragging of bottomsheet
  bottomSheetDragUpdate(DragUpdateDetails details) {
    //prevent animation and drag gestures if the bottom sheet is at max height
    if (dragDistance.value == maxBottomSheetSize) {
      return;
    }
    final double primaryDelta = details.primaryDelta!;

    //if user is swiping up primaryDelta will be less than 0 else greater than 0
    if (primaryDelta < 0) {
      isBottomSheetExpanded.value = true;
    } else if (primaryDelta > 0) {
      isBottomSheetExpanded.value = false;
    }
    //if its == 0 and bottom sheet is expanded
    else if (primaryDelta == 0 && isBottomSheetExpanded.value) {
      isBottomSheetExpanded.value = true;
    } else {
      isBottomSheetExpanded.value == false;
    }
    //update drag distance as user drags screen
    dragDistance.value = updateLargerBottomSheetDragDistance(primaryDelta,
        initialBottomSheetSize, maxBottomSheetSize, dragDistance.value);
    positionedBottomSheetHeight.value = updateSmallerBottomSheetDragDistance(
        primaryDelta,
        smallerBottomsheetHeight,
        positionedBottomSheetHeight.value);
  }

  //called after user lifts finger from screen after dragging bottom sheet
  bottomSheetDragEnd(DragEndDetails details) async {
    //prevent animation and drag gestures if the bottom sheet is at max height
    if (dragDistance.value == maxBottomSheetSize) {
      return;
    }
    //if bottom sheet is expanded
    if (isBottomSheetExpanded.value) {
      _smallerBottomsheetAnim.value = tweenAnimation.animation(
        Tween(
          begin: positionedBottomSheetHeight.value,
          end: smallerBottomsheetHeight,
        ),
      );
      _largerBottomSheetAnim.value = tweenAnimation.animation(
        Tween(
          begin: dragDistance.value,
          end: maxBottomSheetSize,
        ),
      );
      tweenAnimation.startAnimation(from: 0);
      dragDistance.value = maxBottomSheetSize;
      //delay for 300 miliseconds before focusing destination textfield
      Future.delayed(
        const Duration(milliseconds: 300),
        () => Get.focusScope!.requestFocus(destinationFieldfocusNode),
      );
    } else {
      _smallerBottomsheetAnim.value = tweenAnimation.animation(Tween(
          begin: positionedBottomSheetHeight.value,
          end: -_smallBtmsheetCalcHeight!));
      _largerBottomSheetAnim.value = tweenAnimation.animation(
          Tween(begin: dragDistance.value, end: initialBottomSheetSize));
      tweenAnimation.startAnimation(from: 0);
      destinationFieldfocusNode.unfocus();
    }
    //reset drag direction
    isBottomSheetExpanded.value = false;
  }

  // method to return new distance for bottomsheet during dragging
  updateLargerBottomSheetDragDistance(double primaryDelta,
      double initialSheetSize, double maxSheetSize, distance) {
    double newPosition = distance - (primaryDelta / Get.height);
    final double newDistance =
        newPosition.clamp(initialSheetSize, maxSheetSize);
    return newDistance;
  }

// method to return new distance for smaller container
  updateSmallerBottomSheetDragDistance(
      double primaryDelta, double height, distance) {
    double newPosition = distance - primaryDelta;
    double verticalExtent =
        newPosition.clamp(-(height * _deviceHeight), height);
    return verticalExtent;
  }

  @override
  void dispose() {
    scrollController.value.dispose();
    tweenAnimation.dispose();
    destinationFieldfocusNode.dispose();
    pickUpFieldfocusNode.dispose();
    super.dispose();
  }
}
