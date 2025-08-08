import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../models/character_model.dart';
import 'episode_list_page.dart'; // Importe a nova página
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.statusAlive;
      case 'dead':
        return AppColors.statusDead;
      default:
        return AppColors.appBarColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: cardWidth,
              color: Colors.transparent,
              child: Stack(
                children: [
                  // Container azul ocupa todo o card
                  Container(
                    width: cardWidth,
                    // altura total: imagem + infos
                    padding: EdgeInsets.only(top: 80), // metade da altura da imagem para sobrepor
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 64), // Espaço de 16px após a imagem

                          // Nome
                          Text(
                            character.name.toUpperCase(),
                            style: AppFonts.nameCard.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 32), // <-- Espaço grande após o nome

                          // Informações
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getStatusColor(character.status),
                                  border: Border.all(
                                    color: AppColors.fontWhite,
                                    width: 1,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${character.status} - ${character.species}',
                                  style: AppFonts.cardInfo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Gender:', style: AppFonts.cardText),
                          Text(character.gender, style: AppFonts.cardInfo),
                          const SizedBox(height: 8),
                          Text('Last known location:', style: AppFonts.cardText),
                          Text(character.lastLocationName, style: AppFonts.cardInfo),
                          const SizedBox(height: 8),
                          Text('First seen in:', style: AppFonts.cardText),
                          Text(
                            character.firstEpisodeName ?? 'Unknown',
                            style: AppFonts.cardInfo,
                          ),
                          const SizedBox(height: 8),
                          Text('Number of episodes:', style: AppFonts.cardText),
                          RichText(
                            text: TextSpan(
                              style: AppFonts.cardInfo,
                              children: [
                                TextSpan(
                                  text: '${character.episodeUrls.length}',
                                  style: AppFonts.cardInfo.copyWith(
                                    color: AppColors.fontWhite,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 300),
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                              EpisodeListPage(episodeUrls: character.episodeUrls),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32), // <-- Espaço grande após as informações
                        ],
                      ),
                    ),
                  ),
                  // Imagem sobrepondo o topo do container azul
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: cardWidth,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          character.imageUrl,
                          width: cardWidth,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
