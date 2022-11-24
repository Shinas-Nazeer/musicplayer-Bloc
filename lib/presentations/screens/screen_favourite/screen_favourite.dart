import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/widgets/song_list_tile.dart';

class ScreenFavourites extends StatelessWidget {
  ScreenFavourites({super.key, required this.playlistName});
  final String playlistName;

  final Box<List> playlistBox = getPlaylistBox();
  final Box<Songs> songBox = getSongBox();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FavRecentMostBloc>(context).add(
        const GetSongsList(),
      );
    });
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: krose,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          playlistName,
          style: coustomFont(fontSize: 18)
        ),
 
      ),
      body: BlocBuilder<FavRecentMostBloc, FavRecentMostState>(
        builder: (context, state) {
          final songList = (playlistName == 'Favourites')
              ? state.favSongList
              : (playlistName == 'Recent')
                  ? state.recentList
                  : state.mostList;
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            child: songList.isEmpty
                ?  Center(
                    child: Text('The List is Empty',style: coustomFont(fontSize: 18),),
                  )
                : ListView.builder(
                    itemCount: songList.length,
                    itemBuilder: (context, index) {
                      return SongListTile(
                        onPressed: () {
                          showPlaylistModalSheet(
                            context: context,
                            screenHeight: screenHeight,
                            song: songList[index],
                          );
                        },
                        songList: songList,
                        index: index,
                        audioPlayer: audioPlayer,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  showClearAlert({required BuildContext context, required String key}) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: kLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Clear $playlistName',
              style: TextStyle(color: kDarkBlue),
            ),
            content: Text(
              'Do you want to clear $playlistName',
              style: TextStyle(color: kDarkBlue),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  List<Songs> dbSongs = songBox.values.toList().cast<Songs>();
                  await songBox.clear();
                  for (var item in dbSongs) {
                    Songs song = Songs(
                      id: item.id,
                      title: item.title,
                      artist: item.artist,
                      uri: item.uri,
                      count: 0,
                    );
                    await songBox.put(song.id, song);
                  }
                  await playlistBox.put(playlistName, []);
                  BlocProvider.of<FavRecentMostBloc>(context).add(
                    const GetPlaylistLength(),
                  );
                  BlocProvider.of<FavRecentMostBloc>(context).add(
                    const GetSongsList(),
                  );
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
