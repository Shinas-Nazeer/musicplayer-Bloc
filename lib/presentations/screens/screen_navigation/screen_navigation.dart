import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/presentations/screens/screen_home/screen_home.dart';
import 'package:music_player/presentations/screens/screen_playlist/screen_playlist.dart';

import '../screen_search/screen_search.dart';

class ScreenNavigation extends StatelessWidget {
 ScreenNavigation({super.key});

  final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Songs'),
    const Tab(text: 'Playlist'),
  ];
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,

          tabBarTheme: (
            
            
            const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
          width: 2.0,
          color: Color.fromARGB(255, 241, 81, 183),
        )),
        labelColor: Color.fromARGB(255, 241, 81, 183),
        labelStyle: TextStyle(fontFamily: ('Itim'), fontSize: 23.0),
      ))),
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ScreenSearch(
                          audioPlayer: audioPlayer,
                        );
                      },
                    ),
                  );
                     
                    },
                    icon: const Icon(Icons.search))
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: myTabs,
              ),
              title: const Text("Music Player",
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 81, 183),
                      fontFamily: ('Itim'),
                      fontSize: 23.0)),
            ),
         
            body:  TabBarView(children: 
            [ScreenHome(),
              ScreenPlaylist()])),
      ),
    );
  }
}