import 'package:flutter/material.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/widgets/icon_widget.dart';

class PositionedSearchBar extends StatelessWidget {
  const PositionedSearchBar({
    super.key,
    required this.size,
    required this.onTap,
    required this.text,
  });

  final Size size;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        width: size.width,
        height: 45,
        decoration: BoxDecoration(
          color: surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            const IconWidget(
              height: 50,
              width: 50,
              icon: Icons.arrow_back,
            ),
            Expanded(
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                  color: surface,
                  border: null,
                ),
                child: Row(
                  children: [
                    IconWidget(
                      iconSize: 30,
                      height: 30,
                      width: 35,
                      icon: Icons.search,
                      iconColor: Colors.grey.shade500,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
            const IconWidget(height: 50, width: 50, icon: Icons.add),
          ],
        ),
      ),
    );
  }
}
