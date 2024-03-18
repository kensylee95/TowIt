
import 'package:flutter/material.dart';

class PositionedBottomContainer extends StatelessWidget {
  const PositionedBottomContainer({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: child,
    );
  }
}
