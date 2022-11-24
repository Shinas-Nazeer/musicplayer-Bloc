import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_player/application/screen_home/screen_home_bloc.dart';
import 'package:music_player/presentations/alert_functions.dart';

import 'package:music_player/presentations/screens/screen_search/screen_search.dart';

import 'package:music_player/presentations/widgets/song_list_tile.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({
    super.key,
  });
 



  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ScreenHomeBloc>(context).add(const Initailize());
    });
    final screenHeight = MediaQuery.of(context).size.height;
    return 
      
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Expanded(
            child: ListView(
              children: [
               
              
                BlocBuilder<ScreenHomeBloc, ScreenHomeState>(
                  builder: (context, state) {
                    return Container(
                      child: state.songList.isEmpty
                          ? const Text("No Songs Found")
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SongListTile(
                                  onPressed: () {
                                    log(state.songList.length.toString());
                                    showPlaylistModalSheet(
                                      context: context,
                                      screenHeight: screenHeight,
                                      song: state.songList[index],
                                    );
                                  },
                                  songList: state.songList,
                                  index: index,
                                  audioPlayer: audioPlayer,
                                );
                              },
                              itemCount: state.songList.length,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    
  }
}
