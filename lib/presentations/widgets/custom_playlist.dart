import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/presentations/screens/screen_created_playlist/screen_created_playlist.dart';
import 'package:music_player/presentations/screens/screen_favourite/screen_favourite.dart';

import '../../domain/models/songs.dart';



class CustomPlayList extends StatelessWidget {
  const CustomPlayList({super.key, required this.playlistName});
final String playlistName;

  @override
  Widget build(BuildContext context) {
        final List<Songs> songList =
        getPlaylistBox().get(playlistName)!.toList().cast<Songs>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 241, 81, 183)),
              borderRadius: BorderRadius.circular(20)),
              title: Text(playlistName,
              style: TextStyle(fontFamily: ('Itim'),
              fontSize: 14.0,
              color: krose,

              ),
              
              ),

                onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              if (playlistName == 'Favourites') {
                return ScreenFavourites(
                  playlistName: "Favourites",
                );
              }
              if (playlistName == 'Recent') {
                return ScreenFavourites(
                  playlistName: "Recent",
                );
              }
              if (playlistName == 'Most Played') {
                return ScreenFavourites(
                  playlistName: "Most Played",
                );
              }
              return ScreenCreatedPlaylist(
                playlistName: playlistName,
              );
          
          
           
            }
          ));
                }

                
                
      ));       
                
                
                
      }    }