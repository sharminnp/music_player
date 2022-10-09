import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:music_player/widgets/recentFunction.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/types.dart';

class RecentSongs extends StatefulWidget {
  const RecentSongs({Key? key}) : super(key: key);

  @override
  State<RecentSongs> createState() => _RecentSongsState();
}

class _RecentSongsState extends State<RecentSongs> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  final _auidoQuery = OnAudioQuery();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  List<SongTypes>? recentSong;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentSong = PlaylistBox.get('recent')!.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);

    return ValueListenableBuilder(
        valueListenable: PlaylistBox.listenable(),
        builder: (BuildContext context, Box<List> value, Widget? child) {
          List<SongTypes> songList =
              PlaylistBox.get('recent')!.toList().cast<SongTypes>();
          return (songList.isEmpty)
              ? Center(
                  child: Text("No recent songs"),
                )
              : ListView.separated(
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 5,
                      )),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return RecentTile(
                        context: context, songList: songList, index: index);
                  },
                );
        });
  }
}
