import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';

part 'fav_recent_most_event.dart';
part 'fav_recent_most_state.dart';
part 'fav_recent_most_bloc.freezed.dart';

class FavRecentMostBloc extends Bloc<FavRecentMostEvent, FavRecentMostState> {
  FavRecentMostBloc() : super(FavRecentMostState.initial()) {
    Box<List> playlistBox = getPlaylistBox();
    on<GetSongsList>((event, emit) {
      emit(
        FavRecentMostState(
          favSongList: playlistBox.get('Favourites')!.toList().cast<Songs>(),
          recentList: playlistBox.get('Recent')!.toList().cast<Songs>(),
          mostList: playlistBox.get('Most Played')!.toList().cast<Songs>(),
          favSongListlength: state.favSongListlength,
          recentListLength: state.recentListLength,
          mostListLength: state.mostListLength,
        ),
      );
    });

    on<GetPlaylistLength>((event, emit) {
      return emit(
        FavRecentMostState(
          favSongList: state.favSongList,
          mostList: state.mostList,
          recentList: state.recentList,
          favSongListlength: playlistBox.get('Favourites')!.toList().length,
          recentListLength: playlistBox.get('Recent')!.toList().length,
          mostListLength: playlistBox.get('Most Played')!.toList().length,
        ),
      );
    });
  }
}
