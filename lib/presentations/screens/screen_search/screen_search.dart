import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/screen_search/screen_search_bloc.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/presentations/alert_functions.dart';
import 'package:music_player/presentations/widgets/search_widget.dart';
import 'package:music_player/presentations/widgets/song_list_tile.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key, required this.audioPlayer});
  final AssetsAudioPlayer audioPlayer;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ScreenSearchBloc>(context).add(const InitialSearch());
    });
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Search',
          style: coustomFont(fontSize: 20)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
        ),
        child: Column(
          children: [
            SearchField(
              validator: (value) {
                return null;
              },
              textController: _searchController,
              hintText: 'Songs',
              icon: Icons.search,
              onChanged: (value) {
                BlocProvider.of<ScreenSearchBloc>(context).add(
                  SearchStudent(searchValue: value),
                );
              },
            ),
            BlocBuilder<ScreenSearchBloc, ScreenSearchState>(
              builder: (context, state) {
                return Expanded(
                  child: (state.songs.isEmpty)
                      ?  Center(
                          child: Text('No Song Found',
                          style: coustomFont()
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.searchedSongs.length,
                          itemBuilder: (ctx, index) {
                            return SongListTile(
                              onPressed: () {
                                showPlaylistModalSheet(
                                  context: context,
                                  screenHeight: screenHeight,
                                  song: state.searchedSongs[index],
                                );
                              },
                              songList: state.searchedSongs,
                              index: index,
                              audioPlayer: audioPlayer,
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
