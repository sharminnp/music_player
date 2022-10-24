import 'package:flutter/material.dart';
import 'package:music_player/widgets/mostsongs.dart';

class MostPlayedSongsScreen extends StatelessWidget {
  const MostPlayedSongsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9C95A1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff9C95A1),
        centerTitle: true,
        title: const Text(
          "Mostplayed Songs",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff3A2D43),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: const [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 13, right: 13, top: 8),
              child: mostPlayedWidget(),
            ),
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
