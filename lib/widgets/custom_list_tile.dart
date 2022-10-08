import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/types.dart';

import 'package:music_player/widgets/mini_player.dart';
import 'package:music_player/widgets/playlist_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.context,
    required this.songList,
    required this.index,
  }) : super(key: key);

  final BuildContext context;
  final List<SongTypes> songList;
  final int index;

  @override
  State<CustomListTile> createState() => CustomListTileState();
}

class CustomListTileState extends State<CustomListTile> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  Box<List> PlaylistBox = Hive.box<List>("Playlist");

  addSongstoFavourites(
      {required BuildContext context, required String id}) async {
    List<SongTypes> allsongs = songBox.values.toList().cast();

    final List<SongTypes> favSongList =
        PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

    final SongTypes favsong =
        allsongs.firstWhere((song) => song.id.contains(id));

    if (favSongList.where((song) => song.id == favsong.id).isEmpty) {
      favSongList.add(favsong);

      await PlaylistBox.put('favourites', favSongList);
    } else {
      favSongList.removeWhere((songs) => songs.id == favsong.id);
      await PlaylistBox.put('favourites', favSongList);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff4a4e69),
      ),
      // height: 70,
      width: double.infinity,
      child: ListTile(
        onTap: () {
          setState(() {
            isMiniplayerVisible:
            true;
          });

          showminiPlayer(
            context: context,
            songList: widget.songList,
            index: widget.index,
          );
        },
        // contentPadding: EdgeInsets.symmetric(horizontal: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: QueryArtworkWidget(
              artworkBorder: BorderRadius.circular(0),
              id: int.parse(widget.songList[widget.index].id),
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Image.asset("assets/images/images (1).jpg")),
        ),
        title: Text(
          widget.songList[widget.index].title,
          maxLines: 1,
          style: TextStyle(
            color: Color(0xffDCC6C6),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          widget.songList[widget.index].artist,
          maxLines: 1,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: ((context) => [
                PopupMenuItem(
                  onTap: () {
                    addSongstoFavourites(
                        context: context, id: widget.songList[widget.index].id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.black,
                      ),
                      Text("Add to Favourite")
                    ],
                  ),
                ),
                PopupMenuItem(
                    onTap: () {
                      showplaylistmodelbottomsheet(
                        ctx: context,
                        song: widget.songList[widget.index],
                      );
                      // showBottomSheet(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     backgroundColor: Colors.white,
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return Container();
                      //     });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.playlist_add,
                          size: 30,
                          color: Colors.black,
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        Text("Add to Playlist")
                      ],
                    ))
              ]),
        ),
      ),
    );
  }

  showplaylistmodelbottomsheet({
    required BuildContext ctx,
    required SongTypes song,
  }) {
    Box<List> PlaylistBox = Hive.box<List>("Playlist");
    List playlistName = PlaylistBox.keys.toList();
    final List<SongTypes> songList =
        PlaylistBox.get(playlistName)!.toList().cast<SongTypes>();

    return showBottomSheet(
        context: ctx,
        builder: (context) {
          // return Center(child: Text('hh'));
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setstate) {
            return DraggableScrollableSheet(
                builder: (BuildContext context,
                        ScrollController scrollcontroller) =>
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Alertfunc.showCreatingPlaylistDialogue(context);
                            },
                            icon: Icon(Icons.add)),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => ListTile(
                              title: Text("n"),
                              trailing: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete)),
                            ),
                            itemCount: 10,
                          ),
                        ),
                      ],
                    ));
          });
        });
  }

  showminiPlayer(
      {required BuildContext context,
      required List<SongTypes> songList,
      required int index}) {
    showBottomSheet(
      context: context,
      builder: (ctx) {
        return MiniPlayer(
          songList: songList,
          index: index,
        );
      },
    );
  }
}

// showAlertDialog(BuildContext context) {
//   // Create button
//   Widget okButton = FlatButton(
//     child: Text("OK"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );

//   // Create AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Create Folder"),
//     // content: ( Text("enter Folder Name")),
//     content:
//         TextField(decoration: InputDecoration(hintText: "Enter Folder Name")),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
