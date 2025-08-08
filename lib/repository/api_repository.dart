import 'package:dio/dio.dart';
import '../models/character_model.dart';

// ApiRepository: responsável por acessar a API do Rick and Morty usando Dio.
// Fornece métodos para buscar personagens e nomes de episódios.

class ApiRepository {
  // Instância estática do Dio para requisições HTTP
  static final Dio _dio = Dio();

  /// Busca lista de personagens paginada da API
  /// Para cada personagem, busca também o nome do primeiro episódio
  static Future<List<Character>> fetchCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('https://rickandmortyapi.com/api/character?page=$page');
      final data = response.data;
      final List results = data['results'];
      List<Character> characters = results.map((json) => Character.fromJson(json)).toList();

      // Buscar nome do primeiro episódio para cada personagem
      List<Character> updatedCharacters = await Future.wait(characters.map((character) async {
        if (character.episodeUrls.isNotEmpty) {
          try {
            final episodeResponse = await _dio.get(character.episodeUrls.first);
            final episodeData = episodeResponse.data;
            final episodeName = episodeData['name'] as String? ?? 'Desconhecido';
            return character.copyWith(firstEpisodeName: episodeName);
          } catch (_) {
            return character;
          }
        }
        return character;
      }));

      return updatedCharacters;
    } on DioException catch (e) {
      throw Exception('Erro ao carregar personagens: ${e.message}');
    }
  }

  /// Busca nomes dos episódios a partir de uma lista de URLs
  static Future<List<String>> fetchEpisodeNames(List<String> episodeUrls) async {
    return Future.wait(episodeUrls.map((url) async {
      try {
        final response = await _dio.get(url);
        final data = response.data;
        return data['name'] as String? ?? 'Desconhecido';
      } catch (_) {}
      return 'Desconhecido';
    }));
  }
}
