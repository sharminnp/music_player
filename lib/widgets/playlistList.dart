import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:music_player/widgets/textfielPlaylist.dart';

import '../models/types.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PlaylistList extends StatefulWidget {
  PlaylistList({
    Key? key,
    required this.playListName,
    required this.songId,
  }) : super(key: key);
  final String playListName;
  final String songId;

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  String? newPlaylistName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newPlaylistName = widget.playListName;
  }

  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        foregroundDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(7)),
        height: _MediaQuery.size.height * 0.09,
        // width: _MediaQuery.size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Color(0xff4a4e69),
        ),
        child: ListTile(
          onTap: () {
            addSongtoPlaylist(
              context: context,
              id: widget.songId,
              playlistName: widget.playListName,
            );
          },
          title: Text(
            widget.playListName,
            style: TextStyle(color: Colors.white),
          ),
          trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == "0") {
                  print("clicked on Selected");
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      value: "0",
                      onTap: () {
                        print("clicked on ontap");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                print("clicked on iconPressed");
                                Navigator.pop(context);
                                final List<SongTypes> playlistsong =
                                    PlaylistBox.get(newPlaylistName)!
                                        .toList()
                                        .cast<SongTypes>();
                                showEditingPlaylistDialogue(
                                    context: context,
                                    playlistName: widget.playListName,
                                    PlaylistSong: playlistsong);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                        value: 1,
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showPlaylistDeleteAlert(
                                      context: context,
                                      key: widget.playListName);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black,
                                )),
                          ],
                        )),
                  ])),
        ),
      ),
    );
  }

  showEditingPlaylistDialogue(
      {required BuildContext context,
      required String playlistName,
      required List<SongTypes> PlaylistSong}) {
    final TextEditingController textcontroller =
        TextEditingController(text: widget.playListName);
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          final formkey = GlobalKey<FormState>();
          return Form(
              key: formkey,
              child: AlertDialog(
                title: Text("Edit Playlist"),
                content: TextFieldPlaylist(
                  hintText: "Edit Here",
                  validator: (value) {
                    final keys = Hive.box<List>("Playlist").keys.toList();
                    if (value == null || value.isEmpty) {
                      return "feild is empty";
                    }
                    if (keys.contains(value)) {
                      return '$value Already Exist';
                    }
                    return null;
                  },
                  textController: textcontroller,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("cancel")),
                  TextButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          final PlaylistBox = Hive.box<List>("Playlist");
                          setState(() {
                            newPlaylistName = textcontroller.text.trim();
                          });
                          await PlaylistBox.put(newPlaylistName, PlaylistSong);
                          PlaylistBox.delete(playlistName);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Confirm"))
                ],
              ));
        });
  }
}

addSongtoPlaylist(
    {required BuildContext context,
    required id,
    required String playlistName}) async {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  List<SongTypes> playlistsong =
      PlaylistBox.get(playlistName)!.toList().cast<SongTypes>();
  List<SongTypes> allsongs = songBox.values.toList().cast<SongTypes>();
  SongTypes song = allsongs.firstWhere((element) => element.id.contains(id));
  if (playlistsong.contains(song)) {
    ShowplaylistSnackbar(
        context: context,
        songName: song.title,
        message: "Already Existed In The Playlist");
  } else {
    playlistsong.add(song);
    await PlaylistBox.put(playlistName, playlistsong);
    ShowplaylistSnackbar(
        context: context, songName: song.title, message: "Added To Playlist");
  }
}

ShowplaylistSnackbar(
    {required BuildContext context,
    required songName,
    required String message}) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     duration: const Duration(seconds: 1),
  //     content: Container(
  //       height: 50,
  //       child: Column(
  //         children: [Text(message), Text(songName)],
  //       ),
  //     )));
  showTopSnackBar(
    context,
    CustomSnackBar.success(
      message: songName + '\n' + message,
      backgroundColor: Color(0xffDCC6C6),
    ),
  );
}

showPlaylistDeleteAlert({required BuildContext context, required String key}) {
  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Conform Deletion"),
          content: Text("Do you want to Delete this Playlist"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await PlaylistBox.delete(key);
                },
                child: Text("Confirm")),
          ],
        );
      });
}
