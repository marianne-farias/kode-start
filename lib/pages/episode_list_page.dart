import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import '../repository/api_repository.dart';


/// Exibe uma lista de episódios, traduzindo o prefixo "Episode" se necessário.
class EpisodeListPage extends StatefulWidget {
  final List<String> episodeUrls;

  const EpisodeListPage({super.key, required this.episodeUrls});

  @override
  State<EpisodeListPage> createState() => _EpisodeListPageState();
}


class _EpisodeListPageState extends State<EpisodeListPage> {
  late Future<List<String>> _episodesFuture;

  @override
  void initState() {
    super.initState();
    // Busca os nomes dos episódios ao abrir a página
  _episodesFuture = ApiRepository.fetchEpisodeNames(widget.episodeUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usa FutureBuilder para aguardar a resposta da API
      body: FutureBuilder<List<String>>(
        future: _episodesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('error_loading_characters'.tr()));
          }
          final episodes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episodeName = episodes[index];
              // Traduz apenas o prefixo "Episode" se necessário
              final translated = episodeName.toLowerCase().startsWith('episode')
                  ? 'episode'.tr() + episodeName.substring(7)
                  : episodeName;
              return ListTile(
                title: Text(
                  translated.toUpperCase(),
                  style: AppFonts.episode.copyWith(color: AppColors.fontWhite),
                ),
                dense: true,
              );
            },
          );
        },
      ),
    );
  }
}