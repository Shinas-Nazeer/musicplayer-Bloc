// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/screens/screen_navigation/screen_navigation.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  Future<void> fetchSongsAndGotoHomeScreen(BuildContext context) async {
    await fetchSongs(context);
    await gotoHomeScreen(context);
  }

  Future<void> fetchSongs(BuildContext context) async {
    OnAudioQuery audioQuery = OnAudioQuery();
    Box<List> playlistBox = getPlaylistBox();
    Box<Songs> songBox = getSongBox();

    List<SongModel> deviceSongs = [];
    List<SongModel> fetchedSongs = [];

    await Permission.storage.request();
    deviceSongs = await audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (var song in deviceSongs) {
      if (song.fileExtension == 'mp3') {
        fetchedSongs.add(song);
      }
    }

    for (var audio in fetchedSongs) {
      final song = Songs(
        id: audio.id.toString(),
        title: audio.displayNameWOExt,
        artist: audio.artist!,
        uri: audio.uri!,
      );
      await songBox.put(song.id, song);
    }
    //create a Favourite songs if it is not created

    if (!playlistBox.keys.contains('Favourites')) {
      await playlistBox.put('Favourites', []);
    }

    if (!playlistBox.keys.contains('Most Played')) {
      await playlistBox.put('Most Played', []);
    }

    if (!playlistBox.keys.contains('Recent')) {
      await playlistBox.put('Recent', []);
    }
  }

  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => ScreenNavigation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    fetchSongsAndGotoHomeScreen(context);
    return Scaffold(
      body: Center(
        child: Text('Music Palyer', style: coustomFont(fontSize: 20),)
      ),
    );
  }
}
