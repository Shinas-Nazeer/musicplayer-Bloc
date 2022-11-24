import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_player/domain/lyrics/song_lyrics/songLyrics.dart';

Future<SongLyrics> getSongLyrics(
    {required String title, required String artist}) async {
  var uri = Uri.https(
    'powerlyrics.p.rapidapi.com',
    'getlyricsfromtitleandartist',
    {'title': title, 'artist': artist},
  );

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': '07710451e2msh42e766ca3de3d24p1e0648jsn6fd3ee1a103d',
      'X-RapidAPI-Host': 'powerlyrics.p.rapidapi.com'
    },
  );

  final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
  final data = SongLyrics.fromJson(decodedBody);

  return data;
}
