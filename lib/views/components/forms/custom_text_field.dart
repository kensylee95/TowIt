

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    this.prefixIcon,
    this.hintText,
  });

  final TextEditingController textController;
  final Widget? prefixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.apply(color: Colors.grey.shade800),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.apply(color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade100,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
            width: 4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
            width: 4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
            width: 4,
          ),
        ),
      ),
    );
  }
}
