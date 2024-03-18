

import 'package:flutter/material.dart';
import 'package:logistics_app/config/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.size, this.color, this.prefixWidget, this.suffixWidget, required this.text, this.textStyle,
  });

  final Size size;
  final Color? color;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 60,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(side: BorderSide(width: 4, color: surface)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefixWidget?? const SizedBox.shrink(),
            Text(
              text,
              style: textStyle?? Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.apply(color: Colors.black),
            ),
            suffixWidget?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

