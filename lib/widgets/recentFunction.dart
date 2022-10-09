import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/models/types.dart';

import 'package:on_audio_query/on_audio_query.dart';

class RecentTile extends StatefulWidget {
  const RecentTile({
    Key? key,
    required this.context,
    required this.songList,
    required this.index,
  }) : super(key: key);
  final BuildContext context;
  final List<SongTypes> songList;
  final int index;
  @override
  State<RecentTile> createState() => _RecentTileState();
}

class _RecentTileState extends State<RecentTile> {
  static Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  static Box<List> PlaylistBox = Hive.box<List>("Playlist");

//  static addSongstoRecents({required BuildContext context,required String id })async{

//  List<SongTypes> dbSongs = songBox.values.toList().cast();

//     final List<SongTypes> recentSongList =
//         PlaylistBox.get('recent')!.toList().cast<SongTypes>();

//     final SongTypes recentSong =
//         dbSongs.firstWhere((song) => song.id.contains(id));
//     if (recentSongList.where((song) => song.id == recentSong.id).isEmpty){
//       recentSongList.insert(0, recentSong);
//       await PlaylistBox.put('recent', recentSongList);
//     }else{
//       recentSongList.removeWhere((song) => song.id==recentSong.id);
//       recentSongList.insert(0, recentSong);
//       await PlaylistBox.put('recent', recentSongList);
//     }

//  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
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
          style: TextStyle(
            color: Color(0xffDCC6C6),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          widget.songList[widget.index].artist,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
    );
  }
}
