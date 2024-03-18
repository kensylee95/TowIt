
import 'package:flutter/material.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/widgets/icon_widget.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    required this.focusNode,
    required this.hasFocus,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final FocusNode focusNode;
  final bool hasFocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: primary,
            ),
          ),
          filled: hasFocus,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .labelSmall
              ?.apply(color: Colors.grey.shade600),
          prefixIcon: IconWidget(
            width: 20,
            height: 20,
            icon: prefixIcon,
            iconSize: 25,
            iconColor: Colors.grey.shade600,
          )),
    );
  }
}
