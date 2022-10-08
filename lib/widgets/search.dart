import 'package:flutter/material.dart';
import 'package:music_player/widgets/common.dart';

class SearchSongs extends StatefulWidget {
  const SearchSongs({Key? key}) : super(key: key);

  @override
  State<SearchSongs> createState() => _searchSongsState();
}

class _searchSongsState extends State<SearchSongs> {
  List images = [
    "https://a10.gaanacdn.com/gn_img/albums/mGjKrP1W6z/jKrPvDqVW6/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/YoEWlwa3zX/EWlwLE5y3z/size_l.webp",
    "https://a10.gaanacdn.com/gn_img/albums/BZgWoOW2d9/gWoQJyZOK2/size_xs.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/81l3Mye3rM/l3MyEAyG3r/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/koMWQ7BKqL/MWQ7RBp8Kq/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/2lV3dl13Rg/V3dlnwwo3R/size_l.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/d41WjznWPL/1WjzBjy7WP/size_xs.webp",
    "https://c.saavncdn.com/016/Glimpse-of-Us-English-2022-20220608232243-500x500.jpg",
    "https://a10.gaanacdn.com/gn_img/albums/Dk9KNk23Bx/9KNkMnze3B/size_xs.jpg"
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
    "First Class"
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
    "jack Harlows"
  ];
  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return ListView.separated(
        itemCount: 8,
        separatorBuilder: (context, index) => SizedBox(
              height: _MediaQuery.size.height * 0.01,
            ),
        itemBuilder: (context, index) => Searchtile(
            context, images[index], songsName[index], artist[index]));
  }
}



// 