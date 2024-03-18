
import 'package:flutter/material.dart';

class PositionedBottomDraggableSheet extends StatelessWidget {
  const PositionedBottomDraggableSheet({
    super.key,
    required this.initialChildSize,
    required this.maxChildSize,
    required this.minChildSize,
    required this.child,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
  });

  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;
  final void Function(DragUpdateDetails) onVerticalDragUpdate;
  final void Function(DragEndDetails) onVerticalDragEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: true,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return GestureDetector(
          excludeFromSemantics: true,
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            onVerticalDragUpdate(details);
          },
          onVerticalDragEnd: (details) {
            onVerticalDragEnd(details);
          },
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: child),
        );
      },
    );
  }
}
