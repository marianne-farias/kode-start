import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final VoidCallback? onSearch;
  final bool showSearchButton;

  const CustomAppBar({
    super.key,
    this.leading,
    this.onSearch,
    this.showSearchButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ColoredBox(
        color: AppColors.appBarColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: preferredSize.height,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ícone de menu ou back, sempre ocupando o SizedBox
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8), // alinhamento igual ao ícone de pessoa
                      child: SizedBox(
                        width: 31.46,
                        height: 31.46,
                        child: leading,
                      ),
                    ),
                    // Logo centralizada
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Image(
                        image: AssetImage('assets/KobeStartLogo.png'),
                        width: 115,
                        height: 76.99,
                      ),
                    ),
                    // Ícone de pessoa alinhado à direita
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 8),
                      child: Icon(Icons.account_circle, color: Colors.white, size: 31.46),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Título centralizado com botão de pesquisa à direita
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        'RICK AND MORTY API',
                        style: AppFonts.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (showSearchButton)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white, size: 24),
                          onPressed: onSearch,
                          tooltip: 'Pesquisar',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
