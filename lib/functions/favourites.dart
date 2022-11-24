import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';

class Favourites {
  static final Box<List> playlistBox = getPlaylistBox();
  static final Box<Songs> songBox = getSongBox();

  static addSongToFavourites(
      {required BuildContext context, required String id}) async {
    final List<Songs> allSongs = songBox.values.toList().cast();

    final List<Songs> favSongList =
        playlistBox.get('Favourites')!.toList().cast<Songs>();

    final Songs favSong = allSongs.firstWhere((song) => song.id.contains(id));

    if (favSongList.where((song) => song.id == favSong.id).isEmpty) {
      favSongList.add(favSong);
      await playlistBox.put('Favourites', favSongList);
      showFavouritesSnackBar(
          context: context,
          songName: favSong.title,
          message: 'Added to Favourites');
    } else {
      favSongList.removeWhere((songs) => songs.id == favSong.id);
      await playlistBox.put('Favourites', favSongList);
      showFavouritesSnackBar(
          context: context,
          songName: favSong.title,
          message: 'Removed from Favourites');
    }
  }

  static IconData isThisFavourite({required String id}) {
    final List<Songs> allSongs = songBox.values.toList().cast();
    List<Songs> favSongList =
        playlistBox.get('Favourites')!.toList().cast<Songs>();

    Songs favSong = allSongs.firstWhere((song) => song.id.contains(id));
    return favSongList.where((song) => song.id == favSong.id).isEmpty
        ? Icons.favorite_outline_rounded
        : Icons.favorite_rounded;
  }

  static showFavouritesSnackBar(
      {required BuildContext context,
      required String songName,
      required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: krose,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(fontFamily: ('Itim'),
              fontSize: 13,
              color: Colors.white),
              
            ),
            Text(
              songName,
              style: TextStyle(fontFamily: ('Itim'),
              fontSize: 13,
              color: Colors.white),
              // style: coustomFont(fontSize: 13, fontcolor: Colors.white)
              
            ),
          ],
        ),
      ),
    );
  }
}
