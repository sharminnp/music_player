import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/widgets/custom_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Homesongs extends StatefulWidget {
  Homesongs({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;
  @override
  State<Homesongs> createState() => _HomesongsState();
}

class _HomesongsState extends State<Homesongs> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  List<SongTypes>? dbSongs;
  final _auidoQuery = OnAudioQuery();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();

    dbSongs = songBox.values.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return (dbSongs!.isEmpty)
        ? Center(
            child: Text("No songs"),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: _MediaQuery.size.height * 0.01,
            ),
            itemCount: dbSongs!.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                context: context,
                songList: dbSongs!,
                index: index,
              );
            },
          );
  }
}
