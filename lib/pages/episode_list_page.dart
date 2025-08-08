import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_fonts.dart';
import '../services/api_service.dart';

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
    _episodesFuture = ApiService.fetchEpisodeNames(widget.episodeUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _episodesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar episódios'));
          }
          final episodes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                episodes[index].toUpperCase(),
                style: AppFonts.episode.copyWith(color: AppColors.fontWhite)
              ),
              dense: true,
            ),
          );
        },
      ),
    );
  }
}