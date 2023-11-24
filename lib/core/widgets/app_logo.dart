
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.center = false,
  });
  final bool center;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          SizedBox(height: 40, child: Image.asset("assets/icons/logo.png")),
          Text(
            'Diote',
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
