import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {
  static Future<List<Character>> fetchCharacters({int page = 1}) async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character?page=$page'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      List<Character> characters = results.map((json) => Character.fromJson(json)).toList();

      // Buscar nome do primeiro episódio para cada personagem
      List<Character> updatedCharacters = await Future.wait(characters.map((character) async {
        if (character.episodeUrls.isNotEmpty) {
          try {
            final episodeResponse = await http.get(Uri.parse(character.episodeUrls.first));
            if (episodeResponse.statusCode == 200) {
              final episodeData = jsonDecode(episodeResponse.body);
              final episodeName = episodeData['name'] as String? ?? 'Desconhecido';
              return character.copyWith(firstEpisodeName: episodeName);
            }
          } catch (_) {
            // Em caso de erro, retornar character original
            return character;
          }
        }
        return character;
      }));

      return updatedCharacters;
    } else {
      throw Exception('Erro ao carregar personagens');
    }
  }

  static Future<List<String>> fetchEpisodeNames(List<String> episodeUrls) async {
    return Future.wait(episodeUrls.map((url) async {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['name'] as String? ?? 'Desconhecido';
        }
      } catch (_) {}
      return 'Desconhecido';
    }));
  }
}
