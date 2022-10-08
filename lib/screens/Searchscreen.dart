import 'package:flutter/material.dart';
import 'package:music_player/widgets/common.dart';
import 'package:music_player/widgets/mini_player.dart';
import 'package:music_player/widgets/search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff9C95A1),
        appBar: AppBar(
          backgroundColor: Color(0xff9C95A1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Search List",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff3A2D43),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: _MediaQuery.size.height * 0.06,
              width: _MediaQuery.size.width * 0.90,
              decoration: BoxDecoration(
                color: Colors.white54,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.search, color: Colors.black45),
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: "Search here",
                          hintStyle: TextStyle(color: Colors.black45)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 20),
                child: SearchSongs(),
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
      ),
    );
  }
}
