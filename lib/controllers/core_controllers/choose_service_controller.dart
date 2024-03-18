import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/controllers/Animations/tween_animation.dart';
import 'package:logistics_app/views/core/choose_service.dart';

class ChooseServiceController extends GetxController{
  static ChooseService get instance => Get.find();
  //tween animation class instance
  TweenAnimation tweenAnimation = Get.put(TweenAnimation());
  //offset for scroll controller
  final positionedOffset = 0.0.obs;
 final Rx<ScrollController> scrollController = Rx<ScrollController>(ScrollController());
  final dragDistance = 0.0.obs;
  final RxDouble positionedBottomSheetHeight = RxDouble(0.0);
  RxBool isBottomSheetExpanded = false.obs;
  double initialBottomSheetSize = 0.45;
  double maxBottomSheetSize = 0.88;
  late Rx<Animation<double>> _largerBottomSheetAnim;
  //smaller sheet
  double smallerBottomsheetHeight = 0.2;
  late Rx<Animation<double>> _smallerBottomsheetAnim;
  Animation get smallerBottomsheetAnim => _smallerBottomsheetAnim.value;
  @override
  void onInit() {
    _onInit();
    super.onInit();
  }

   void _onInit(){
    //initial value of drag distance
    dragDistance.value = initialBottomSheetSize;
    //initial height of the smaller animated container
    final double smallerBottomsheetInitialHeight =
        Get.height * smallerBottomsheetHeight;
    //animation of smaller container
   _smallerBottomsheetAnim =  Rx<Animation<double>>(tweenAnimation.animation(Tween(begin:0.0, end:smallerBottomsheetInitialHeight)));
   //animation of larger container
   _largerBottomSheetAnim =   Rx<Animation<double>>(tweenAnimation.animation(Tween(begin:smallerBottomsheetHeight, end:initialBottomSheetSize)));
    //animation controller listener
    tweenAnimation.animationController.addListener(()=>_updatePositionedBottomSheetHeight(),); 
    
  }
  @override
  void onReady() {
  //initial animation duration
 tweenAnimation.animationController.duration = const Duration(milliseconds: 600);
 //start the animation
  tweenAnimation.startAnimation();
  //subsequent animation duration
  tweenAnimation.animationController.duration = const Duration(milliseconds: 300);
    super.onReady();
  }
 
 //called to update the the states of both smaller container and bottom sheet 
  void _updatePositionedBottomSheetHeight() {
    positionedBottomSheetHeight.value = _smallerBottomsheetAnim.value.value;
   dragDistance.value = _largerBottomSheetAnim.value.value;
  }


  updatePositionedOffset({required double height}) {
    positionedOffset.value = (scrollController.value.position.viewportDimension -
            scrollController.value.offset) /
        2;
  }
  //called during bottom sheet drag
  bottomSheetDragUpdate(DragUpdateDetails details) {
    final double primaryDelta = details.primaryDelta!;
    
    //if user is swiping up primaryDelta will be less than 0 else greater than 0
    if (primaryDelta < 0) {
      isBottomSheetExpanded.value = true;
    } else if (primaryDelta > 0) {
      isBottomSheetExpanded.value = false;
    } else if (primaryDelta == 0 && isBottomSheetExpanded.value) {
      isBottomSheetExpanded.value = true;
    } else {
      isBottomSheetExpanded.value == false;
    }

    dragDistance.value = updateLargerBottomSheetDragDistance(primaryDelta,
        initialBottomSheetSize, maxBottomSheetSize, dragDistance.value);
    positionedBottomSheetHeight.value = updateSmallerBottomSheetDragDistance(
        primaryDelta,
        smallerBottomsheetHeight,
        positionedBottomSheetHeight.value);
  }
  //called after bottom sheet drag
  bottomSheetDragEnd(DragEndDetails details) async{
    if (isBottomSheetExpanded.value) {
      _smallerBottomsheetAnim.value = tweenAnimation.animation(Tween(begin:positionedBottomSheetHeight.value, end:0));
      _largerBottomSheetAnim.value = tweenAnimation.animation(Tween(begin:dragDistance.value, end:maxBottomSheetSize));
       tweenAnimation.startAnimation(from: 0);
       
      //dragDistance.value = maxBottomSheetSize;
      //positionedBottomSheetHeight.value = 0.0;
    } else {
       _smallerBottomsheetAnim.value = tweenAnimation.animation(Tween(begin:positionedBottomSheetHeight.value, end:Get.height*smallerBottomsheetHeight));
      _largerBottomSheetAnim.value = tweenAnimation.animation(Tween(begin:dragDistance.value, end:initialBottomSheetSize));
      tweenAnimation.startAnimation(from: 0);
      //dragDistance.value = initialBottomSheetSize;
      //positionedBottomSheetHeight.value = Get.height*smallerBottomsheetHeight;
    }
    //reset drag direction
    isBottomSheetExpanded.value = false;
  }

  updateLargerBottomSheetDragDistance(double primaryDelta,
      double initialSheetSize, double maxSheetSize, distance) {
    double newPosition = distance - (primaryDelta / Get.height);
    final double newDistance =
        newPosition.clamp(initialSheetSize, maxSheetSize);
    return newDistance;
  }

  updateSmallerBottomSheetDragDistance(
      double primaryDelta, double height, distance) {
    double newPosition = distance + primaryDelta;
    double verticalExtent = newPosition.clamp(0, height * Get.height);
    return verticalExtent;
  }

  @override
  void dispose() {
    scrollController.value.dispose();
    tweenAnimation.removeListener(() { });
    tweenAnimation.dispose();
    super.dispose();
  }
}
