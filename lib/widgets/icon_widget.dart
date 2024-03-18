
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
  });
  final double width;
  final double height;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor ?? Colors.transparent,
        width: width,
        height: height,
        child: Center(
          child: Icon(
            icon,
            size: iconSize ?? 25,
            color: iconColor ?? Colors.black,
          ),
        ));
  }
}
