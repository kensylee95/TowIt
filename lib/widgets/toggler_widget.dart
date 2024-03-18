
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TogglerWidget extends StatelessWidget {
  const TogglerWidget({
    super.key,
    required this.onTap,
    required this.size,
  });

  final VoidCallback onTap;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        width: size.width,
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade100),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade300),
              child: const Center(
                child: Icon(
                  Icons.search_outlined,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "From Where?",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
