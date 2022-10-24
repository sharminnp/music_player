import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/screens/Playlist_Screen.dart';

import 'package:music_player/widgets/playlistList.dart';
import 'package:music_player/widgets/playlist_function.dart';

import 'package:music_player/widgets/textfielPlaylist.dart';

import '../models/types.dart';

class PlaylistFolderScreen extends StatefulWidget {
  PlaylistFolderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaylistFolderScreen> createState() => _PlaylistFolderScreenState();
}

class _PlaylistFolderScreenState extends State<PlaylistFolderScreen> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");

  String? newPlaylistName;
  String? playlistName;
  SongTypes? song;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Color(0xff9C95A1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff9C95A1),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Alertfunc.showCreatingPlaylistDialogue(context);
                  },
                  icon: Icon(
                    Icons.library_add,
                    size: 30,
                    color: Color(0xff3A2D43),
                  )),
            ),
          ],
        ),
        body: ValueListenableBuilder(
            valueListenable: PlaylistBox.listenable(),
            builder: (context, value, child) {
              List keys = PlaylistBox.keys.toList();
              keys.removeWhere((element) => element == 'favourites');
              keys.removeWhere((element) => element == 'recent');
              keys.removeWhere((element) => element == 'mostlyPlayed');

              return (keys.isEmpty)
                  ? Center(
                      child: Text("Save your Music Collection in Playlist"),
                    )
                  : GridView.builder(
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        final String playlistName = keys[index];
                        final List<SongTypes> playlistSongList =
                            PlaylistBox.get(playlistName)!
                                .toList()
                                .cast<SongTypes>();
                        final int playlistSongListlength =
                            playlistSongList.length;
                        // return folderplaylist(context, playlistName, );
                        return folderplaylist(context, playlistName,
                            '$playlistSongListlength songs');
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // mainAxisSpacing: 5,
                        // crossAxisSpacing: 5,
                        childAspectRatio: 3 / 2,
                      ),
                    );
            }));
  }

  folderplaylist(BuildContext context, String playlistName, String text) {
    var _MediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => PlaylistScreen(
                      playlistName: playlistName,
                    ),
                  ));
              addSongtoPlaylist(
                  context: context, id: song!.id, playlistName: playlistName);
            },
            child: Container(
              height: _MediaQuery.size.height * 0.120,
              width: _MediaQuery.size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff4a4e69),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 25),
                    child: Text(
                      playlistName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDCC6C6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                    ),
                    child: Row(
                      children: [
                        Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: PopupMenuButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                              itemBuilder: ((ctx) => [
                                    PopupMenuItem(
                                      value: "0",
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                // final List<SongTypes> playlistsong =
                                                //     PlaylistBox.get(newPlaylistName)!
                                                //         .toList()
                                                //         .cast<SongTypes>();
                                                //
                                                Navigator.pop(context);
                                                showeditAlert(
                                                  context: ctx,
                                                  playlistName: playlistName,
                                                );
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showPlaylistDeleteAlert(
                                                    context: ctx,
                                                    key: playlistName);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )),
                                  ])),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  showEditingPlaylistDialogue(
      {required BuildContext context,
      required String playlistName,
      required List<SongTypes> PlaylistSong}) {
    final TextEditingController textcontroller =
        TextEditingController(text: playlistName);
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

                          newPlaylistName = textcontroller.text.trim();

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

  showeditAlert({
    required BuildContext context,
    required String playlistName,
  }) {
    final TextEditingController textcontroller =
        TextEditingController(text: playlistName);
    Box<List> PlaylistBox = Hive.box<List>("Playlist");
    return showDialog(
        context: context,
        builder: (ctx) {
          final formkey = GlobalKey<FormState>();
          return Form(
            key: formkey,
            child: AlertDialog(
              title: Text("Edit playlist"),
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
                      Navigator.pop(ctx);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        final PlaylistBox = Hive.box<List>("Playlist");

                        newPlaylistName = textcontroller.text.trim();
                        final playListSongs =
                            PlaylistBox.get(playlistName)!.toList();
                        await PlaylistBox.put(newPlaylistName, playListSongs);
                        PlaylistBox.delete(playlistName);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Confirm")),
              ],
            ),
          );
        });
  }
}
