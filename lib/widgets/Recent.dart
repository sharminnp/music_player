import 'package:flutter/cupertino.dart';

import 'package:music_player/widgets/common.dart';

class RecentSongs extends StatefulWidget {
  const RecentSongs({Key? key}) : super(key: key);

  @override
  State<RecentSongs> createState() => _RecentSongsState();
}

class _RecentSongsState extends State<RecentSongs> {
  List images = [
    "https://a10.gaanacdn.com/gn_img/albums/mGjKrP1W6z/jKrPvDqVW6/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/YoEWlwa3zX/EWlwLE5y3z/size_l.webp",
    "https://a10.gaanacdn.com/gn_img/albums/BZgWoOW2d9/gWoQJyZOK2/size_xs.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/81l3Mye3rM/l3MyEAyG3r/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/koMWQ7BKqL/MWQ7RBp8Kq/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/2lV3dl13Rg/V3dlnwwo3R/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/d41WjznWPL/1WjzBjy7WP/size_xs.webp",
    "https://c.saavncdn.com/016/Glimpse-of-Us-English-2022-20220608232243-500x500.jpg",
  ];
  List songsName = [
    "As it Was",
    "Hope",
    "You",
    "La La Love",
    "Heat Waves",
    "True Love",
    "My Universe",
    "Glimpse of Us",
  ];
  List artist = [
    "Harry style",
    "Xxxtentacion",
    "Armaan Malik",
    "Elnaaz Norouzi",
    "Fenecot",
    "Kanye West",
    "coldplay,BTS",
    "Joji",
  ];
  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);

    return ListView.separated(
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(
              height: _MediaQuery.size.height * 0.01,
            ),
        itemBuilder: (context, index) => recentstile(
            context, images[index], songsName[index], artist[index]));
  }
}
