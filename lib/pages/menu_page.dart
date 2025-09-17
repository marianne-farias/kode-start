import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';


// MenuPage: página lateral para seleção de idioma e futuras opções de menu.
// Permite ao usuário alternar entre inglês e português.

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o idioma atual
    final locale = context.locale;
    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        children: [
          // Linha de seleção de idioma
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'select_language'.tr().toUpperCase(),
                style: AppFonts.episode,
              ),
              const SizedBox(width: 24),
              // Botão para inglês
              ElevatedButton(
                onPressed: () => context.setLocale(const Locale('en')),
                child: const Text('EN-US'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(60, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: locale.languageCode == 'en' ? AppColors.cardColor : AppColors.appBarColor,
                  foregroundColor: AppColors.fontWhite,
                ),
              ),
              const SizedBox(width: 8),
              // Botão para português
              ElevatedButton(
                onPressed: () => context.setLocale(const Locale('pt')),
                child: const Text('PT-BR'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(60, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: locale.languageCode == 'pt' ? AppColors.cardColor : AppColors.appBarColor,
                  foregroundColor: AppColors.fontWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
