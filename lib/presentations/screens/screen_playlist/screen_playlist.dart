import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/application/screen_created_playlist/screen_created_playlist_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/alert_functions.dart';

import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/widgets/created_playlist.dart';
import 'package:music_player/presentations/widgets/custom_playlist.dart';

class ScreenPlaylist extends StatelessWidget {
  Box<List> playlistBox = getPlaylistBox();
  ScreenPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
        const GetPlaylistListNames(),
      );
    });
 
    return 
        ListView(
          children: [
            BlocBuilder<FavRecentMostBloc, FavRecentMostState>(
              builder: (context, state) {
                return Column(
                  children: [
                    CustomPlayList(
                      playlistName: 'Favourites',
                    ),
                    CustomPlayList(
                      playlistName: 'Recent',
                    ),
                    CustomPlayList(
                      playlistName: 'Most Played',
                    ),
                  ],
                );
              },
            ),

            BlocBuilder<ScreenCreatedPlaylistBloc,
                ScreenCreatedPlaylistState>(
              builder: (context, state) {
                BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
                  const GetPlaylistListNames(),
                );
                return state.playlistListNames.isEmpty
                    ? Center(
                        child: Text('No Playlist Found', style: coustomFont(fontSize: 15),),
                      )
                    : ListView.builder(
                        itemCount: state.playlistListNames.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),

                        itemBuilder: (context, index) {
                          final String playlistName =
                              state.playlistListNames[index];

                          // final List<Songs> songList = playlistBox
                          //     .get(playlistName)!
                          //     .toList()
                          //     .cast<Songs>();

                          // final int songListlength = songList.length;

                          return CreatedPlaylist(

                            playlistName: playlistName,

                          );
                        },
                      );
              },
            ),
          ],
        );
    
   
  }
}
