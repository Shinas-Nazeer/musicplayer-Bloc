import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/domain/models/db_functions/db_function.dart';
import 'package:music_player/domain/models/songs.dart';

part 'screen_home_event.dart';
part 'screen_home_state.dart';
part 'screen_home_bloc.freezed.dart';

class ScreenHomeBloc extends Bloc<ScreenHomeEvent, ScreenHomeState> {
  ScreenHomeBloc() : super(ScreenHomeState.initial()) {
    Box<List> playlistBox = getPlaylistBox();
    on<Initailize>((event, emit) {
      emit(ScreenHomeState(
        songList: state.songList,
      ));
    });
  }
}
