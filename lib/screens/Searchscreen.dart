import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/widgets/custom_list_tile.dart';
import 'package:music_player/widgets/search.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _auidoQuery = OnAudioQuery();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();
  TextEditingController searchController = new TextEditingController();
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  List<SongTypes>? dbSongs;
  bool isVisible = true;

  List<SongTypes> _foundSong = [];

  @override
  void initState() {
    // TODO: implement initState
    dbSongs = songBox.values.toList().cast<SongTypes>();

    _foundSong = List.from(dbSongs!);
    super.initState();
  }

  void SearchSongs(String enteredKeyboard) {
    List<SongTypes> results = [];
    if (enteredKeyboard.isEmpty) {
      results = dbSongs!;
    } else {
      results = dbSongs!
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(enteredKeyboard.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundSong = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Color(0xff9C95A1),
        appBar: AppBar(
          backgroundColor: Color(0xff9C95A1),
          elevation: 0,
          title: Text(
            "Search List",
            style: TextStyle(
              color: Color(0xff3A2D43),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enableSuggestions: true,
                style: TextStyle(
                  color: Color(0xff4a4e69),
                ),
                onChanged: (value) => SearchSongs(value),
                controller: searchController,
                decoration: InputDecoration(
                    prefixIconColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Search here"),
              ),
            ),

            // ignore: non_constant_identifier_names
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: songBox.listenable(),
                builder: (context, Box<SongTypes> Songs, Widget? child) {
                  if (Songs.values == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (_foundSong.isEmpty) {
                    return Center(
                      child: Text("No songs Found"),
                    );
                  }
                  return ListView.separated(
                    itemCount: _foundSong.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: _MediaQuery.size.height * 0.005,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 7),
                        child: CustomListTile(
                          context: context,
                          songList: _foundSong,
                          index: index,
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        )));
  }
}
