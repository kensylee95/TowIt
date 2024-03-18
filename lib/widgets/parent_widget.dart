import 'package:flutter/material.dart';
import 'package:logistics_app/config/colors.dart';

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key, required this.child, this.appBar});
  final Widget child;
  final PreferredSize? appBar;

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: surface,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: child,
      ),
    );
  }
}
