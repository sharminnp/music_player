import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/widgets/custom_list_tile.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../models/types.dart';

class mostPlayedWidget extends StatefulWidget {
  const mostPlayedWidget({Key? key}) : super(key: key);

  @override
  State<mostPlayedWidget> createState() => _mostPlayedWidgetState();
}

class _mostPlayedWidgetState extends State<mostPlayedWidget> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");

  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  List<SongTypes>? mostSong;
  List<SongTypes>? dbSongs;
  final _auidoQuery = OnAudioQuery();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    // List<SongTypes>? temp =
    //     PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
    // TODO: implement initState
    // if (temp == null) {
    //   return;
    // } else {
    //   mostSong = temp.toList().cast<SongTypes>();
    // }
    mostSong = PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
    dbSongs = songBox.values.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return ValueListenableBuilder(
        valueListenable: PlaylistBox.listenable(),
        builder: (BuildContext context, Box<List> value, Widget? child) {
          List<SongTypes> songList = [];
          // PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
          List<dynamic>? _temp = PlaylistBox.get('mostlyPlayed');
          if (_temp == null) {
            return Center(
              child: Text("No Mostplayed songs"),
            );
          } else {
            songList = _temp.toList().cast<SongTypes>();
          }
          return (songList.isEmpty)
              ? Center(
                  child: Text("No Mostplayed songs"),
                )
              : ListView.separated(
                  separatorBuilder: ((context, index) => SizedBox(
                        height: _MediaQuery.size.height * 0.01,
                      )),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    // return mostPlayed(
                    //     context: context, songList: songList, index: index);
                    return CustomListTile(
                        context: context, songList: mostSong!, index: index);
                  },
                );
        });
  }
}
