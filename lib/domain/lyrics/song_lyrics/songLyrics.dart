class SongLyrics {
  final String title;
  final String artist;
  final String lyrics;

  SongLyrics({
    required this.title,
    required this.artist,
    required this.lyrics,
  });

  factory SongLyrics.fromJson(Map<String, dynamic> json) {
    return SongLyrics(
      title: json['requestedtitle'] ?? '' as String,
      artist: json['requestedartist'] ?? '' as String,
      lyrics: json['lyrics'] ?? 'Unable to find the mucis' as String,
    );
  }
}
