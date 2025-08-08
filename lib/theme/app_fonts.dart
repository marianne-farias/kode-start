import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class AppFonts {
  // Title: Lato, weight 400 (regular), size 14.5
  static TextStyle title = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    letterSpacing: 2.4,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );

  // Name Card: Lato, weight 900 (black), size 14.5
  static TextStyle nameCard = GoogleFonts.lato(
    fontWeight: FontWeight.w900,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );

  // Card Info: Lato, weight 500 (medium), size 12.5
  static TextStyle cardInfo = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 12.5,
    color: AppColors.fontWhite
  );

  // Card Text: Lato, weight 300 (light), size 12.5
  static TextStyle cardText = GoogleFonts.lato(
    fontWeight: FontWeight.w300,
    fontSize: 12.5,
    color: AppColors.fontWhite
  );

   // Episode: Lato, weight 400 (regular), size 14.5
  static TextStyle episode = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );

}
