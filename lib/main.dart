import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/pages/home_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import 'package:easy_localization/easy_localization.dart';


/// Função principal do app. Inicializa o binding do Flutter, a internacionalização
/// e define o estilo da status bar. Em seguida, executa o app com EasyLocalization.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Define cor e ícones da status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.appBarColor,
    statusBarIconBrightness: Brightness.light,
  ));

  // Inicializa o app com suporte a múltiplos idiomas
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('pt')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const RickAndMortyApp(),
    ),
  );
}


/// Widget principal do app, define o tema, página inicial e configurações de localização.
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
      // Configurações de localização
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
