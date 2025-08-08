import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Adicionado para configurar a status bar
import 'package:rick_and_morty_app/pages/home_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o binding está pronto

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.appBarColor, // Mesma cor do AppBar
    statusBarIconBrightness: Brightness.light, // Ícones brancos se fundo for escuro
  ));

  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',

      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.appBarColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,

        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: AppFonts.nameCard.copyWith(
            color: AppColors.fontWhite,
            fontSize: 20,
          ),
        ),

        textTheme: TextTheme(
          titleLarge: AppFonts.title.copyWith(color: AppColors.fontWhite),
          bodySmall: AppFonts.cardText.copyWith(color: AppColors.fontWhite),
          bodyMedium: AppFonts.cardInfo.copyWith(color: AppColors.fontWhite),
          titleMedium: AppFonts.nameCard.copyWith(color: AppColors.fontWhite),
        ),
      ),

      home: const HomePage(),

      debugShowCheckedModeBanner: false,
    );
  }
}
