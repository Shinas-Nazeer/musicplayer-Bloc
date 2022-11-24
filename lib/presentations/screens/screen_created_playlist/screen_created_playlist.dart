// ignore_for_file: use_build_context_synchronously
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/screen_created_playlist/screen_created_playlist_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/functions/playlist.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/widgets/search_widget.dart';
import 'package:music_player/presentations/widgets/song_list_tile.dart';

class ScreenCreatedPlaylist extends StatelessWidget {
  ScreenCreatedPlaylist({
    super.key,
    required this.playlistName,
  });
  final String playlistName;

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
      GetPlaylistSongs(playlistName: playlistName),
    );
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
        title:
            BlocBuilder<ScreenCreatedPlaylistBloc, ScreenCreatedPlaylistState>(
          builder: (context, state) {
            return Text(
              state.playlistName,
              style: const TextStyle(
                fontFamily: ('Itim'),
                color: krose,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        actions: [
          BlocBuilder<ScreenCreatedPlaylistBloc, ScreenCreatedPlaylistState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  showEditingPlaylistDialoge(
                    context: context,
                    playlistName: state.playlistName,
                    playlistSongs: state.playlistSongs,
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: krose,
                ),
              );
            },
          ),
          BlocBuilder<ScreenCreatedPlaylistBloc, ScreenCreatedPlaylistState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  showSongModalSheet(
                    context: context,
                    screenHeight: screenHeight,
                    playlistKey: state.playlistName,
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 27,
                  color: krose,
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ScreenCreatedPlaylistBloc, ScreenCreatedPlaylistState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            child: state.playlistSongs.isEmpty
                ? const Center(
                    child: Text('No Songs Found', style: TextStyle( fontFamily: ('Itim'),
                color: krose,),),
                  )
                : ListView.builder(
                    itemCount: state.playlistSongs.length,
                    itemBuilder: (ctx, index) {
                      return SongListTile(
                        icon: Icons.delete_outline_rounded,
                        onPressed: () {
                          UserPlaylist.deleteFromPlaylist(
                            context: context,
                            songId: state.playlistSongs[index].id,
                            playlistName: state.playlistName,
                          );
                        },
                        songList: state.playlistSongs,
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

  showEditingPlaylistDialoge({
    required BuildContext context,
    required String playlistName,
    required List<Songs> playlistSongs,
  }) {
    final TextEditingController textController =
        TextEditingController(text: playlistName);
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          final formKey = GlobalKey<FormState>();
          return Form(
            key: formKey,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              
              title: Text(
                'Edit playlist',
                style: coustomFont(fontSize: 18)
                
              ),
              content: SearchField(
                textController: textController,
                hintText: 'Playlist Name',
                icon: Icons.playlist_add,
                validator: (value) {
                  final keys = getPlaylistBox().keys.toList();
                  if (value == null || value.isEmpty) {
                    return 'Field is empty';
                  }
                  if (keys.contains(value)) {
                    return '$value already exist in playlist';
                  }
                  return null;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    'Cancel',
                    style: coustomFont(fontSize: 15)
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final newPlaylistName = textController.text.trim();
                      BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
                        RenamePlaylist(
                          newPlaylistName: newPlaylistName,
                          oldPlaylistName: playlistName,
                        ),
                      );

                      BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
                        const GetPlaylistListNames(),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child:  Text(
                    'Confirm',
                    style: coustomFont(fontSize: 15)
                  ),
                ),
              ],
            ),
          );
        });
  }
}
