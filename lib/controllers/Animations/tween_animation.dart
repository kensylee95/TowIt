import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TweenAnimation extends GetxController with GetSingleTickerProviderStateMixin{
late Rx<AnimationController> _animController;
  AnimationController get animationController => _animController.value;
  @override
  void onInit() {
    _animController = Rx<AnimationController>(AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))); 
    super.onInit();
  }
   Animation<double>animation(Tween<double> tween) {
   return  tween.animate(
      CurvedAnimation(
        parent: _animController.value,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
 void startAnimation({double? from}){
    _animController.value.forward(from: from);
  }
  @override
  void dispose() {
    _animController.value.dispose();
    super.dispose();
  }
}