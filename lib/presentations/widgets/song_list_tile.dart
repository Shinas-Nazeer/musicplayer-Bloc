import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/functions/favourites.dart';
import 'package:music_player/functions/recents.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    Key? key,
    this.icon = Icons.playlist_add,
    required this.onPressed,
    required this.songList,
    required this.index,
    required this.audioPlayer,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;
  final int index;
  final AssetsAudioPlayer audioPlayer;
  final List<Songs> songList;

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.all(6.0),
      child: ListTile(
         shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                  borderRadius: BorderRadius.circular(20)),
        onTap: () {
          Recents.addSongsToRecents(songId: songList[index].id, context: context);
          showMiniPlayer(
            context: context,
            index: index,
            songList: songList,
            audioPlayer: audioPlayer,
          );
        },
       
        leading: QueryArtworkWidget(
          artworkBorder: BorderRadius.circular(10),
          id: int.parse(songList[index].id),
          type: ArtworkType.AUDIO,
            nullArtworkWidget: const Icon(Icons.music_note,
                color: Color.fromARGB(255, 241, 81, 183))
        ),
        title: Text(
          songList[index].title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontFamily: ('Itim'),
            color: krose,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          
          songList[index].artist == '<unknown>'
              ? 'Unknown'
              : songList[index].artist,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: krose,
            fontSize: 13,
            fontFamily: ('Itim')
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              padding: const EdgeInsets.only(left: 0),
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: krose,
                size: 27,
              ),
            ),
            BlocBuilder<FavRecentMostBloc, FavRecentMostState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    Favourites.addSongToFavourites(
                      context: context,
                      id: songList[index].id,
                    );
                    BlocProvider.of<FavRecentMostBloc>(context).add(
                      const GetSongsList(),
                    );
                    BlocProvider.of<FavRecentMostBloc>(context).add(
                      const GetPlaylistLength(),
                    );
                  },
                  icon: Icon(
                    state.favSongList
                            .where((song) => song.id == songList[index].id)
                            .isEmpty
                        ? Icons.favorite_outline_rounded
                        : Icons.favorite_rounded,
                    color:krose,
                    size: 25,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
