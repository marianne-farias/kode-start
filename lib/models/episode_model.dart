class Episode {
  final String name;

  Episode({required this.name});

  /// Cria um Episode a partir de um JSON da API
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      name: json['name'] as String? ?? 'Desconhecido',
    );
  }
}
