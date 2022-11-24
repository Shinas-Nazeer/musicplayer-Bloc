import 'package:flutter/material.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/constants/palettes/color_palette.dart';
import 'package:music_player/presentations/screens/screen_created_playlist/screen_created_playlist.dart';

import '../../constants/constants.dart';




class CreatedPlaylist extends StatelessWidget {
  const CreatedPlaylist({
    Key? key,

    required this.playlistName,
   
  }) : super(key: key);
  
  final String playlistName;


  @override
  Widget build(BuildContext context) {
    return Padding(padding:const EdgeInsets.all(8.0),
    child: ListTile(
       shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 241, 81, 183)),
              borderRadius: BorderRadius.circular(20)),
               onLongPress: () {
        showPlaylistDeleteAlert(context: context, key: playlistName);
      },
              onTap: () {
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ScreenCreatedPlaylist(
              playlistName: playlistName,
            ),
          ),
        );
                
              },
      title: Text(playlistName,
      
       style: const TextStyle(fontFamily: ('Itim'),
              fontSize: 14.0,
              color: krose,

              ),
      
      ),
    ),



    
     );
    

  

  }
}

