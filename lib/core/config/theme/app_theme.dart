import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      textTheme: GoogleFonts.latoTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      useMaterial3: true,
    );
  }
}
