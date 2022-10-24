import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/types.dart';

Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
Box<List> PlaylistBox = Hive.box<List>("Playlist");

addSongstoRecents({required BuildContext context, required String id}) async {
  List<SongTypes> dbSongs = songBox.values.toList().cast<SongTypes>();

  final List<SongTypes> recentSongList =
      PlaylistBox.get('recent')!.toList().cast<SongTypes>();

  final SongTypes recentSong =
      dbSongs.firstWhere((song) => song.id.contains(id));
  /////////////////////////////////////////////////////////
  int count = recentSong.count;
  recentSong.count = count + 1;
  log(recentSong.count.toString());
  addSongstoMostlyPlayed(id);
//////////////////////////////////////////////////////////
  if (recentSongList.length >= 10) {
    recentSongList.removeLast();
  }

  if (recentSongList.where((song) => song.id == recentSong.id).isEmpty) {
    recentSongList.insert(0, recentSong);
    await PlaylistBox.put('recent', recentSongList);
  } else {
    recentSongList.removeWhere((song) => song.id == recentSong.id);
    recentSongList.insert(0, recentSong);
    await PlaylistBox.put('recent', recentSongList);
  }
}

addSongstoMostlyPlayed(String id) async {
  final List<SongTypes> mostPlayedList =
      PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
  final dbSongs = songBox.values.toList().cast<SongTypes>();
  final mostPlayedSong = dbSongs.firstWhere((song) => song.id.contains(id));
  if (mostPlayedList.length >= 10) {
    mostPlayedList.removeLast();
  }
  if (mostPlayedSong.count >= 3) {
    if (mostPlayedList.where((song) => song.id == mostPlayedSong.id).isEmpty) {
      mostPlayedList.insert(0, mostPlayedSong);
      await PlaylistBox.put('mostlyPlayed', mostPlayedList);
    } else {
      mostPlayedList.removeWhere((song) => song.id == mostPlayedSong.id);
      mostPlayedList.insert(0, mostPlayedSong);
      await PlaylistBox.put('mostlyPlayed', mostPlayedList);
    }
  }
}

addSongstoFavourites(
    {required BuildContext context, required String id}) async {
  List<SongTypes> allsongs = songBox.values.toList().cast();

  final List<SongTypes> favSongList =
      PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

  final SongTypes favsong = allsongs.firstWhere((song) => song.id.contains(id));

  if (favSongList.where((song) => song.id == favsong.id).isEmpty) {
    favSongList.add(favsong);

    await PlaylistBox.put('favourites', favSongList);
    showFavouriteSnackbar(
        context: context,
        songName: favsong.title,
        message: "Added To Favourite");
  } else {
    favSongList.removeWhere((songs) => songs.id == favsong.id);
    await PlaylistBox.put('favourites', favSongList);
    showFavouriteSnackbar(
        context: context,
        songName: favsong.title,
        message: "Removed From Favourites");
  }
}

IconData isThisFavourite({required String id}) {
  final List<SongTypes> allsongs = songBox.values.toList().cast();

  List<SongTypes> favSongList =
      PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

  SongTypes favsong = allsongs.firstWhere((song) => song.id.contains(id));

  return favSongList.where((song) => song.id == favsong.id).isEmpty
      ? Icons.favorite_outline
      : Icons.favorite;
}

showFavouriteSnackbar(
    {required BuildContext context,
    required String songName,
    required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Color(0xff3A2D43),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        duration: Duration(seconds: 1),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              maxLines: 1,
              style: TextStyle(fontSize: 15),
            ),
            Text(
              songName,
              maxLines: 1,
              style: TextStyle(fontSize: 13),
            )
          ],
        )),
  );
}
