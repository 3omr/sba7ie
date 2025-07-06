import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextManagement {
  static TextStyle cairoBold = GoogleFonts.cairo(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle cairoSemiBold = GoogleFonts.cairo(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  static TextStyle cairoRegular = GoogleFonts.cairo(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  static TextStyle cairoLight = GoogleFonts.cairo(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: Colors.white,
    letterSpacing: 0.2,
  );
}