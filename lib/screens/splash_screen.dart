import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/models/types.dart';

import 'package:music_player/screens/home.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> fetchedSongs = [];
  List<SongTypes> dbSongs = [];
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  List<SongTypes> favSongList = [];
  List<SongTypes> recentSongList = [];
  List<SongTypes> MostSongList = [];

  Future<void> requestPermission() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
    fetchphonesongs();
    _navigatetohome();
    getFavourites();
    getrecent();
    getmostly();
  }

  getFavourites() {
    if (!PlaylistBox.keys.contains('favourites')) {
      PlaylistBox.put('favourites', favSongList);
    }
  }

  getrecent() {
    if (!PlaylistBox.keys.contains('recent')) {
      PlaylistBox.put('recent', recentSongList);
    }
  }

  getmostly() {
    if (PlaylistBox.keys.contains('mostlyPlayed')) {
      PlaylistBox.put('mostlyPlayed', MostSongList);
    }
  }

  fetchphonesongs() async {
    fetchedSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (var songModel in fetchedSongs) {
      final song = SongTypes(
        id: songModel.id.toString(),
        title: songModel.title,
        artist: songModel.artist!,
        uri: songModel.uri!,
      );
      dbSongs.add(song);
    }

    for (var song in dbSongs) {
      await songBox.put(song.id, song);
    }
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9C95A1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 310),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/image1.png",
                  width: 130,
                  height: 130,
                ),
                Text(
                  "TUNIFLY",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Color(0xff3A2D43),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
