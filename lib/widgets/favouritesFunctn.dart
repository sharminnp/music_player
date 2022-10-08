import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_player/models/types.dart';

import 'package:on_audio_query/on_audio_query.dart';

class FavFunction extends StatefulWidget {
  const FavFunction({
    Key? key,
    required this.context,
    required this.songList,
    required this.index,
  }) : super(key: key);
  final BuildContext context;
  final List<SongTypes> songList;
  final int index;
  @override
  State<FavFunction> createState() => _FavFunctionState();
}

class _FavFunctionState extends State<FavFunction> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");

  addSongstoFavourites(
      {required BuildContext context, required String id}) async {
    List<SongTypes> allsongs = songBox.values.toList().cast();

    final List<SongTypes> favSongList =
        PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

    final SongTypes favsong =
        allsongs.firstWhere((song) => song.id.contains(id));

    if (favSongList.where((song) => song.id == favsong.id).isEmpty) {
      favSongList.add(favsong);

      await PlaylistBox.put('favourites', favSongList);
    } else {
      favSongList.removeWhere((songs) => songs.id == favsong.id);
      await PlaylistBox.put('favourites', favSongList);
    }
  }

  IconData isThisFavourite({required String id}) {
    final List<SongTypes> allsongs = songBox.values.toList().cast();

    List<SongTypes> favSongList =
        PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

    SongTypes favsong = allsongs.firstWhere((song) => song.id.contains(id));

    return favSongList.where((song) => song.id == favsong.id).isEmpty
        ? Icons.favorite_outline_outlined
        : Icons.favorite;
  }

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              color: Colors.white60,
              onPressed: () {},
              icon: Icon(Icons.playlist_add),
            ),
            IconButton(
              color: Colors.white70,
              onPressed: () {
                addSongstoFavourites(
                    context: context, id: widget.songList[widget.index].id);
              },
              icon: Icon(isThisFavourite(id: widget.songList[widget.index].id)),
            ),
          ],
        ),
      ),
    );
  }
}

//
//   var _MediaQuery = MediaQuery.of(context);
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Color(0xff4a4e69),
//     ),
//     // height: 70,
//     width: double.infinity,
//     child: ListTile(
//       // contentPadding: EdgeInsets.symmetric(horizontal: 4),
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           image,
//           height: _MediaQuery.size.height * 0.8,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(
//         widget.songList[widget.index].title,
//         style: TextStyle(
//           color: Color(0xffDCC6C6),
//           fontWeight: FontWeight.w700,
//           fontSize: 16,
//         ),
//       ),
//       subtitle: Text(
//         artist,
//         style: TextStyle(color: Colors.white, fontSize: 12),
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             color: Colors.white60,
//             onPressed: () {},
//             icon: Icon(Icons.playlist_add),
//           ),
//           IconButton(
//             color: Colors.white70,
//             onPressed: () {},
//             icon: Icon(Icons.favorite),
//           ),
//         ],
//       ),
//     ),
//   );
// }