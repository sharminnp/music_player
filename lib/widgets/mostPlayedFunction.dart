import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/types.dart';

class mostPlayed extends StatefulWidget {
  const mostPlayed({
    Key? key,
    required this.context,
    required this.songList,
    required this.index,
  }) : super(key: key);
  final BuildContext context;
  final List<SongTypes> songList;
  final int index;

  @override
  State<mostPlayed> createState() => _mostPlayedState();
}

class _mostPlayedState extends State<mostPlayed> {
  static Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  static Box<List> PlaylistBox = Hive.box<List>("Playlist");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff4a4e69),
      ),
      // height: 70,
      width: double.infinity,
      child: ListTile(
        // contentPadding: EdgeInsets.symmetric(horizontal: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: QueryArtworkWidget(
              artworkBorder: BorderRadius.circular(0),
              id: int.parse(widget.songList[widget.index].id),
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Image.asset("assets/images/images (1).jpg")),
        ),
        title: Text(
          widget.songList[widget.index].title,
          maxLines: 1,
          style: TextStyle(
            color: Color(0xffDCC6C6),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          widget.songList[widget.index].artist,
          maxLines: 1,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
    );
  }
}
