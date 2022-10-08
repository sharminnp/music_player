import 'package:flutter/material.dart';
import 'package:music_player/widgets/common.dart';
import 'package:music_player/widgets/mini_player.dart';
import 'package:music_player/widgets/playlistsong.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9C95A1),
      appBar: AppBar(
        backgroundColor: Color(0xff9C95A1),
        title: Text(
          "Playlist",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff3A2D43),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 80),
            child: PlaylistSong(),
          ),
          // MiniPlayer(
          //   context: context,
          //   image:
          //       "https://a10.gaanacdn.com/gn_img/albums/mGjKrP1W6z/jKrPvDqVW6/size_l.jpg",
          //   songname: 'Always',
          //   artist: 'Isak Danielson',
          // ),
        ],
      ),
    );
  }
}
