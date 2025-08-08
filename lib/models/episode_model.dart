class Episode {
  final String name;

  Episode({required this.name});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      name: json['name'] as String? ?? 'Desconhecido',
    );
  }
}
