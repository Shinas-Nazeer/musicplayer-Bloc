// ignore_for_file: use_build_context_synchronously

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/screen_created_playlist/screen_created_playlist_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/functions/playlist.dart';

import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/widgets/mini_player.dart';
import 'package:music_player/presentations/widgets/search_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

showMiniPlayer({
  required BuildContext context,
  required int index,
  required List<Songs> songList,
  required AssetsAudioPlayer audioPlayer,
}) {
  return showBottomSheet(
      
      context: context,
      builder: (ctx) {
        return MiniPlayer(
          songList: songList,
          index: index,
          audioPlayer: audioPlayer,
        );
      });
}

showPlaylistModalSheet({
  required BuildContext context,
  required double screenHeight,
  required Songs song,
}) {
  BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
    const GetPlaylistListNames(),
  );
  return showModalBottomSheet(
     
      context: context,
      builder: (ctx) {
        return  Column(
            children: [
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  showCreatingPlaylistDialoge(context: ctx);
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                label: const Text(
                  'Create Playlist',
                  style: TextStyle(fontFamily: ('Itim'),
                  color: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: krose,
                  shape: const StadiumBorder(),
                ),
              ),
              BlocBuilder<ScreenCreatedPlaylistBloc,
                  ScreenCreatedPlaylistState>(
                builder: (context, state) {
                  return Expanded(
                    child: (state.playlistListNames.isEmpty)
                        ? const Center(
                            child: Text("No Playlist Found",
                           style: TextStyle(fontFamily: ('Itim'),
                           color: krose), ),
                          )
                        : ListView.builder(
                            itemCount: state.playlistListNames.length,
                            itemBuilder: (ctx, index) {
                              final String playlistKey =
                                  state.playlistListNames[index];

                              return 
                              
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: ListTile(
                                  
                                        shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                  borderRadius: BorderRadius.circular(20)),
                                    onTap: () async {
                                      UserPlaylist.addSongToPlaylist(
                                          context: context,
                                          songId: song.id,
                                          playlistName: playlistKey);

                                      Navigator.pop(context);
                                    },
                                  
                                    title: Text(playlistKey,
                                    style: TextStyle(
                                      fontFamily: ('Itim'),
                           color: krose
                                    ),),
                                  ),
                               );
                              
                            },
                          ),
                  );
                },
              )
            ],
          );
        
      },
      );
}

showCreatingPlaylistDialoge({required BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  Box<List> playlistBox = getPlaylistBox();

  Future<void> createNewplaylist() async {
    List<Songs> songList = [];
    final String playlistName = textEditingController.text.trim();
    if (playlistName.isEmpty) {
      return;
    }
    await playlistBox.put(playlistName, songList);
    BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
      const GetPlaylistListNames(),
    );
  }

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Create playlist',
              style: TextStyle(
                fontFamily: ('Itim'),
                  color: krose, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            content: SearchField(
              textController: textEditingController,
              hintText: 'Playlist Name',
              icon: Icons.playlist_add,
              validator: (value) {
                final keys = getPlaylistBox().keys.toList();
                if (value == null || value.isEmpty) {
                  return 'Field is empty';
                }
                if (keys.contains(value)) {
                  return '$value Already exist in playlist';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: krose, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await createNewplaylist();
                    Navigator.pop(ctx);
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: krose, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      });
}

showPlaylistDeleteAlert({required BuildContext context, required String key}) {
  final playlistBox = getPlaylistBox();
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Confirm Deletion',
            style: coustomFont(fontSize: 14)
          ),
          content:  Text(
            'Do you want to delete this Playlist ?',
            style: coustomFont(fontSize: 18)
            
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
              await playlistBox.delete(key);
                Navigator.pop(ctx);
                BlocProvider.of<ScreenCreatedPlaylistBloc>(context).add(
                  const GetPlaylistListNames(),
                );
              },
              child:  Text(
                'OK',
                style: coustomFont(fontSize: 15.0)
              ),
            ),
          ],
        );
      });
}

showSongModalSheet({
  required BuildContext context,
  required double screenHeight,
  required String playlistKey,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) {
      final songBox = getSongBox();
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        height: screenHeight * 0.55,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
             Text(
              'Add Songs',
              style: coustomFont(fontSize: 18)
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songBox.values.length,
                itemBuilder: (BuildContext ctx, int index) {
                  final List<Songs> songsList = songBox.values.toList();
                  final Songs song = songsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: ListTile(
                      onTap: () {
                        UserPlaylist.addSongToPlaylist(
                          context: context,
                          songId: song.id,
                          playlistName: playlistKey,
                        );

                        Navigator.pop(context);
                      },
                      leading: QueryArtworkWidget(
                        id: int.parse(song.id),
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.circular(10),
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Icon(Icons.music_note,color: krose,)
                        ),
                      ),
                      title: Text(
                        song.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: coustomFont(fontSize: 15)
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
