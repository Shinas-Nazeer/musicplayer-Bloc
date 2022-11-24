import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';

class MostPlayed {
  static final Box<Songs> songBox = getSongBox();
  static final Box<List> playlistBox = getPlaylistBox();

  static addSongToPlaylist(String songId, BuildContext context) async {
    final mostPlayedlist =
        playlistBox.get('Most Played')!.toList().cast<Songs>();

    final dbSongs = songBox.values.toList().cast<Songs>();

    final mostPlayedSong =
        dbSongs.firstWhere((song) => song.id.contains(songId));
    if (mostPlayedlist.length >= 10) {
      mostPlayedlist.removeLast();
    }
    if (mostPlayedSong.count >= 5) {
      if (mostPlayedlist
          .where((song) => song.id == mostPlayedSong.id)
          .isEmpty) {
        mostPlayedlist.insert(0, mostPlayedSong);
        await playlistBox.put('Most Played', mostPlayedlist);
        BlocProvider.of<FavRecentMostBloc>(context).add(
          const GetPlaylistLength(),
        );
      } else {
        mostPlayedlist.removeWhere((song) => song.id == mostPlayedSong.id);
        mostPlayedlist.insert(0, mostPlayedSong);
        await playlistBox.put('Most Played', mostPlayedlist);
      }
    }
  }
}
