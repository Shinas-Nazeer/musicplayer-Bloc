import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/functions/recents.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/screens/screen_now_playing/screen_now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatelessWidget {
  MiniPlayer({
    Key? key,
    required this.songList,
    required this.index,
    required this.audioPlayer,
  }) : super(key: key);

  final List<Songs> songList;
  final int index;
  final AssetsAudioPlayer audioPlayer;

  List<Audio> songAudio = [];

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  void convertSongMode() {
    for (var song in songList) {
      songAudio.add(
        Audio.file(
          song.uri,
          metas: Metas(
            id: song.id.toString(),
            title: song.title,
            artist: song.artist,
          ),
        ),
      );
    }
  }

  Future<void> openAudioPLayer() async {
    convertSongMode();

    await audioPlayer.open(
      Playlist(
        audios: songAudio,
        startIndex: index,
      ),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.playlist,
      playInBackground: PlayInBackground.enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    openAudioPLayer();
    final screenHeight = MediaQuery.of(context).size.height;
    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        final myAudio = find(songAudio, playing.audio.assetAudioPath);
        Recents.addSongsToRecents(songId: myAudio.metas.id!, context: context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
       
            height: screenHeight * 0.075,
            width: double.infinity,
            decoration: BoxDecoration(
           
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return ScreenNowPlaying(
                          songList: songAudio,
                          index: index,
                          id: myAudio.metas.id!,
                          audioPlayer: audioPlayer,
                        );
                      },
                    ),
                  );
                },
               
                leading: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(10),
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:const Icon(Icons.music_note,
                      color: krose,)
                    )),
                title: TextScroll(
                  audioPlayer.getCurrentAudioTitle,
                  velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                  style:
                      const TextStyle(
                        fontFamily: ('Itim'),
                        color: krose,
                        fontSize: 15, fontWeight: FontWeight.w600),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await audioPlayer.previous();
                      },
                      child: const Icon(
                        Icons.skip_previous,
                        color: krose,
                        size: 33,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () async {
                        await audioPlayer.playOrPause();
                      },
                      child: PlayerBuilder.isPlaying(
                          player: audioPlayer,
                          builder: (context, isPlaying) {
                            return Icon(
                              isPlaying == true ? Icons.pause : Icons.play_arrow,
                              color: krose,
                              size: 33,
                            );
                          }),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () async {
                        await audioPlayer.next();
                      },
                      child: const Icon(
                        Icons.skip_next,
                        color: krose,
                        size: 33,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
