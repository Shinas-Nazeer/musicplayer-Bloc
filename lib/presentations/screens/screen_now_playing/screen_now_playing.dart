import 'dart:developer';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/functions/favourites.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/functions/recents.dart';
import 'package:music_player/domain/lyrics/lyrics_api.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/widgets/custom_icon_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class ScreenNowPlaying extends StatelessWidget {
  ScreenNowPlaying({
    super.key,
    required this.songList,
    required this.index,
    required this.audioPlayer,
    required this.id,
  });

  final List<Audio> songList;
  final int index;
  final String id;
  final AssetsAudioPlayer audioPlayer;

  String newLyrics = 'Tap the button to get the Lyrics';
  PageController? pageController;

  void initState() {
    pageController = PageController(
      viewportFraction: 1,
      keepPage: true,
      initialPage: index,
    );
  }

  bool isShuffle = true;

 

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return audioPlayer.builderCurrent(builder: (context, playing) {
      final myAudio = find(songList, playing.audio.assetAudioPath);
      Recents.addSongsToRecents(songId: myAudio.metas.id!, context: context);

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: krose,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title:  Text(
            'Now Playing',
            style: coustomFont()
          ),
      
        ),
        body: PageView.builder(
          onPageChanged: (newValue) {
            audioPlayer.playlistPlayAtIndex(newValue);
          },
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: songList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
               
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: QueryArtworkWidget(
                            artworkHeight: screenHeight * 0.4,
                            artworkWidth: double.infinity,
                            id: int.parse(myAudio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              'assets/images/cover_art.png',
                              fit: BoxFit.cover,
                              height: screenHeight * 0.4,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.07),
                      Center(
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          height: 30,
                          child: Center(
                            child: TextScroll(
                              audioPlayer.getCurrentAudioTitle,
                              textAlign: TextAlign.center,
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(45, 0)),
                              mode: TextScrollMode.endless,
                              style: coustomFont(fontSize: 18)
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          audioPlayer.getCurrentAudioArtist == '<unknown>'
                              ? 'Unknown'
                              : audioPlayer.getCurrentAudioArtist,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: coustomFont(fontSize: 15)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              icon: Icons.playlist_add,
                              onPressed: () {
                                final song = Songs(
                                  id: myAudio.metas.id!,
                                  title: myAudio.metas.title!,
                                  artist: myAudio.metas.artist!,
                                  uri: myAudio.path,
                                );
                                showPlaylistModalSheet(
                                  context: context,
                                  screenHeight: screenHeight,
                                  song: song,
                                );
                              },
                            ),
                            PlayerBuilder.realtimePlayingInfos(
                                player: audioPlayer,
                                builder: (context, realTimeInfos) {
                                  return IconButton(onPressed: (){
                                      audioPlayer.toggleShuffle();  
                                  }, icon: ( Icon(
                          Icons.shuffle_rounded,
                          size: 30.0,
                          color:(audioPlayer.isShuffling.value == true) ? Colors.grey :krose
                        ) ));
                               
                                }),
                            PlayerBuilder.loopMode(
                                player: audioPlayer,
                                builder: (context, loopMode) {
                                  return IconButton(onPressed: (){
                                        if (loopMode == LoopMode.playlist) {
                                        audioPlayer
                                            .setLoopMode(LoopMode.single);
                                      } else {
                                        audioPlayer
                                            .setLoopMode(LoopMode.playlist);
                                      }
                                  }, icon: 
                                  Icon(
                          Icons.loop_rounded,
                          size: 30.0,
                          color: (loopMode == LoopMode.playlist) ?  krose :Colors.grey
                        ));
                                 
                                }),
                            BlocBuilder<FavRecentMostBloc, FavRecentMostState>(
                              builder: (context, state) {
                                return CustomIconButton(
                                  icon: state.favSongList
                                          .where((song) =>
                                              song.id ==
                                              songList[index].metas.id)
                                          .isEmpty
                                      ? Icons.favorite_outline_rounded
                                      : Icons.favorite_rounded,
                                  onPressed: () {
                                    Favourites.addSongToFavourites(
                                      context: context,
                                      id: myAudio.metas.id!,
                                    );

                                    BlocProvider.of<FavRecentMostBloc>(context)
                                        .add(
                                      const GetSongsList(),
                                    );

                                    BlocProvider.of<FavRecentMostBloc>(context)
                                        .add(
                                      const GetPlaylistLength(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      audioPlayer.builderRealtimePlayingInfos(
                          builder: (context, info) {
                        final duration = info.current!.audio.duration;
                        final position = info.currentPosition;

                        return ProgressBar(
                          progress: position,
                          total: duration,
                          progressBarColor: krose,
                          baseBarColor: Colors.grey,
                          thumbColor: krose,
                          bufferedBarColor: krose,
                          barHeight: 7.0,
                          thumbRadius: 9.0,
                          onSeek: (duration) {
                            audioPlayer.seek(duration);
                          },
                          timeLabelPadding: 10,
                          timeLabelTextStyle: coustomFont(fontSize: 15),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: Icons.skip_previous,
                            onPressed: () async {
                            
                           
                          
                              await audioPlayer.previous();
                              Recents.addSongsToRecents(
                                  songId: myAudio.metas.id!, context: context);
                            },
                          ),
                       
                          Container(
                            decoration: const BoxDecoration(
                              color: kWhite,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                      icon: Icon(
                                        (isPlaying == true)
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: krose,
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        audioPlayer.playOrPause();
                                      },
                                    );
                                  }),
                            ),
                          ),
                        
                          CustomIconButton(
                            icon: Icons.skip_next,
                            onPressed: () async {
                             
                          
                              await audioPlayer.next();
                              Recents.addSongsToRecents(
                                songId: myAudio.metas.id!,
                                context: context,
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.09),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }

  
}
