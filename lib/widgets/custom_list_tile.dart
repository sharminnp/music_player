import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/functions/recentMostFav.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/screens/Playing_Screen.dart';
import 'package:music_player/widgets/Recent.dart';
import 'package:music_player/widgets/mini_player.dart';
import 'package:music_player/widgets/playlistList.dart';
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

  // addSongstoFavourites(
  //     {required BuildContext context, required String id}) async {
  //   List<SongTypes> allsongs = songBox.values.toList().cast();

  //   final List<SongTypes> favSongList =
  //       PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

  //   final SongTypes favsong =
  //       allsongs.firstWhere((song) => song.id.contains(id));

  //   if (favSongList.where((song) => song.id == favsong.id).isEmpty) {
  //     favSongList.add(favsong);

  //     await PlaylistBox.put('favourites', favSongList);
  //     showFavouriteSnackbar(
  //         context: context,
  //         songName: favsong.title,
  //         message: "Added To Favourite");
  //   } else {
  //     favSongList.removeWhere((songs) => songs.id == favsong.id);
  //     await PlaylistBox.put('favourites', favSongList);
  //     showFavouriteSnackbar(
  //         context: context,
  //         songName: favsong.title,
  //         message: "Removed From Favourites");
  //   }
  // }

  // IconData isThisFavourite({required String id}) {
  //   final List<SongTypes> allsongs = songBox.values.toList().cast();

  //   List<SongTypes> favSongList =
  //       PlaylistBox.get('favourites')!.toList().cast<SongTypes>();

  //   SongTypes favsong = allsongs.firstWhere((song) => song.id.contains(id));

  //   return favSongList.where((song) => song.id == favsong.id).isEmpty
  //       ? Icons.favorite_outline
  //       : Icons.favorite;
  // }

  // showFavouriteSnackbar(
  //     {required BuildContext context,
  //     required String songName,
  //     required String message}) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //         backgroundColor: Color(0xff3A2D43),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //         duration: Duration(seconds: 1),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               message,
  //               maxLines: 1,
  //               style: TextStyle(fontSize: 15),
  //             ),
  //             Text(
  //               songName,
  //               maxLines: 1,
  //               style: TextStyle(fontSize: 13),
  //             )
  //           ],
  //         )),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return widget.audioPlayer.builderCurrent (
    //   builder: (BuildContext context, Playing? playing){
    //      final myAudio = find(songAudio, playing!.audio.assetAudioPath);
    // child:
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff4a4e69),
      ),
      // height: 70,
      width: double.infinity,
      child: ListTile(
        onTap: () {
          setState(() {});

          showminiPlayer(
            context: context,
            songList: widget.songList,
            index: widget.index,
          );
          //  PlayingScreen.addSongstoRecents(id:myAudio.metas.id! );
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
          onSelected: (value) {
            if (value == 0) {
              print("called");
            }
            if (value == 1) {
              showplaylistmodelbottomsheet(
                ctx: context,
                songId: widget.songList[widget.index].id,
              );
              print("called 2nd");
            }
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: ((context) => [
                PopupMenuItem(
                  value: 0,
                  onTap: () {
                    addSongstoFavourites(
                        context: context, id: widget.songList[widget.index].id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(isThisFavourite(
                          id: widget.songList[widget.index].id)),
                      const Text("Add to Favourite")
                    ],
                  ),
                ),
                PopupMenuItem(
                    value: 1,
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
  // );
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
// }

showplaylistmodelbottomsheet({
  required BuildContext ctx,
  required String songId,
}) {
  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  var _MediaQuery = MediaQuery.of(ctx);
  showModalBottomSheet(
    context: ctx,
    builder: (BuildContext context) {
      return Container(
          height: _MediaQuery.size.height * 0.55,
          width: double.infinity,
          color: Color(0xff9C95A1),
          child: Column(children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3A2D43),
                ),
                onPressed: () {
                  Alertfunc.showCreatingPlaylistDialogue(context);
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  "Create Playlist",
                )),
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: PlaylistBox.listenable(),
                    builder: (context, value, child) {
                      List keys = PlaylistBox.keys.toList();
                      keys.removeWhere((element) => element == 'favourites');
                      keys.removeWhere((element) => element == 'recent');
                      keys.removeWhere((element) => element == 'mostlyPlayed');

                      return (keys.isEmpty)
                          ? Center(
                              child: Text(
                                  "Save your Music Collection in Playlist"),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: _MediaQuery.size.height * 0.01,
                              ),
                              itemCount: keys.length,
                              itemBuilder: (context, index) {
                                final String playlistName = keys[index];

                                return PlaylistList(
                                  playListName: playlistName,
                                  songId: songId,
                                );
                              },
                            );
                    }))
          ]));
    },
  );
}
