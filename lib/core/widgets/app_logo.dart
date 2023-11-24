// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
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
          SizedBox(height: 45, child: Image.asset("assets/icons/logo.png")),
          AutoSizeText(
            'Diot',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
