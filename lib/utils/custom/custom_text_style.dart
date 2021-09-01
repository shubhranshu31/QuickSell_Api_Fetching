import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customTextStyle({
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 14,
}) {
  return GoogleFonts.montserrat(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    
  );
}
