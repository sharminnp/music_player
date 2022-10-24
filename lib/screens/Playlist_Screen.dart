import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/widgets/custom_list_tile.dart';

import 'package:music_player/widgets/favouritesFunctn.dart';

import 'package:music_player/widgets/playlistsong.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({Key? key, required this.playlistName}) : super(key: key);
  final String playlistName;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");

  Box<List> PlaylistBox = Hive.box<List>("Playlist");

  List<SongTypes>? dbSongs;

  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbSongs = songBox.values.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xff9C95A1),
      appBar: AppBar(
        backgroundColor: Color(0xff9C95A1),
        title: Text(
          widget.playlistName,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff3A2D43),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: PlaylistBox.listenable(),
        builder: (BuildContext context, Box<List> value, Widget? child) {
          List<SongTypes> songList =
              PlaylistBox.get(widget.playlistName)!.toList().cast<SongTypes>();

          return (songList.isEmpty)
              ? Center(
                  child: Text("No playlist songs"),
                )
              : ListView.separated(
                  separatorBuilder: ((context, index) => SizedBox(
                        height: _MediaQuery.size.height * 0.01,
                      )),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 13, top: 5),
                      child: PlaylistSongs(
                        context: context,
                        songList: songList,
                        index: index,
                        playlistName: widget.playlistName,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
