import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/pages/home_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.appBarColor,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pt')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const RickAndMortyApp(),
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
