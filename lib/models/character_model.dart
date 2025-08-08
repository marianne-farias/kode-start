class Character {
  final int id;
  final String name;
  final String imageUrl;
  final String status;
  final String species;
  final String gender;
  final String originName;
  final String lastLocationName;
  final List<String> episodeUrls;
  final String? firstEpisodeName;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.species,
    required this.gender,
    required this.originName,
    required this.lastLocationName,
    required this.episodeUrls,
    this.firstEpisodeName,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image'] as String? ?? '',
      status: json['status'] as String? ?? 'Unknown',
      species: json['species'] as String? ?? 'Unknown',
      gender: json['gender'] as String? ?? 'Unknown',
      originName: json['origin']?['name'] as String? ?? 'Unknown',
      lastLocationName: json['location']?['name'] as String? ?? 'Unknown',
      episodeUrls: List<String>.from(json['episode'] ?? []),
      firstEpisodeName: null, // será preenchido no serviço após buscar o nome do primeiro episódio
    );
  }

  Character copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? status,
    String? species,
    String? gender,
    String? originName,
    String? lastLocationName,
    List<String>? episodeUrls,
    String? firstEpisodeName,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      originName: originName ?? this.originName,
      lastLocationName: lastLocationName ?? this.lastLocationName,
      episodeUrls: episodeUrls ?? this.episodeUrls,
      firstEpisodeName: firstEpisodeName ?? this.firstEpisodeName,
    );
  }
}
