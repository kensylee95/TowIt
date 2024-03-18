import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.size, this.color, this.prefixWidget, this.suffixWidget, required this.text, required this.onPressed,
  });

  final Size size;
  final Color? color;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefixWidget?? const SizedBox.shrink(),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.apply(color: Colors.white),
            ),
            suffixWidget?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

