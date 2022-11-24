import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';

part 'screen_search_event.dart';
part 'screen_search_state.dart';
part 'screen_search_bloc.freezed.dart';

class ScreenSearchBloc extends Bloc<ScreenSearchEvent, ScreenSearchState> {
  ScreenSearchBloc() : super(ScreenSearchState.initial()) {
    on<InitialSearch>((event, emit) {
      Box<Songs> songBox = getSongBox();
      emit(ScreenSearchState(
        songs: songBox.values.toList(),
        searchedSongs: songBox.values.toList(),
      ));
    });

    on<SearchStudent>((event, emit) {
      List<Songs> _searchSongList = state.searchedSongs;
      _searchSongList = state.songs
          .where((song) => song.title
              .toLowerCase()
              .contains(event.searchValue.toLowerCase()))
          .toList();
      emit(ScreenSearchState(
        songs: state.songs,
        searchedSongs: _searchSongList,
      ));
    });
  }
}
