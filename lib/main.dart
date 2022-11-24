import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/fav_recent_most/fav_recent_most_bloc.dart';
import 'package:music_player/application/screen_created_playlist/screen_created_playlist_bloc.dart';
import 'package:music_player/application/screen_home/screen_home_bloc.dart';

import 'package:music_player/application/screen_search/screen_search_bloc.dart';


import 'package:music_player/domain/models/songs.dart';
import 'package:music_player/presentations/screens/screen_splash/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }
  await Hive.openBox<Songs>("Songs");
  await Hive.openBox<List>("Playlist");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider(create: (context) => ScreenHomeBloc()),
      
        BlocProvider(create: (context) => ScreenSearchBloc()),
        BlocProvider(create: (context) => ScreenCreatedPlaylistBloc()),
        BlocProvider(create: (context) => FavRecentMostBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: ('itim')
 
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
