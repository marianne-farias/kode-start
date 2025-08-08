import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class AppFonts {
  // Título principal
  static TextStyle title = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    letterSpacing: 2.4,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );

  // Nome do personagem no card
  static TextStyle nameCard = GoogleFonts.lato(
    fontWeight: FontWeight.w900,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );

  // Informações do card (espécie, status, etc)
  static TextStyle cardInfo = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 12.5,
    color: AppColors.fontWhite
  );

  // Texto secundário do card
  static TextStyle cardText = GoogleFonts.lato(
    fontWeight: FontWeight.w300,
    fontSize: 12.5,
    color: AppColors.fontWhite
  );

  // Nome do episódio
  static TextStyle episode = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    fontSize: 14.5,
    color: AppColors.fontWhite
  );
}
