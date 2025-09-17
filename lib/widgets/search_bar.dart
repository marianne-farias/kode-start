import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

/// Widget reutilizável para barra de busca de personagens.
class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: controller,
            autofocus: true,
            style: AppFonts.cardInfo.copyWith(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'search_character'.tr(),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: AppColors.appBarColor,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
