import 'package:flutter/material.dart';
import 'package:music_player/widgets/common.dart';
import 'package:music_player/widgets/mini_player.dart';

import 'package:music_player/widgets/playlistFolder.dart';
import 'package:music_player/widgets/playlist_function.dart';

class PlaylistFolderScreen extends StatefulWidget {
  PlaylistFolderScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistFolderScreen> createState() => _PlaylistFolderScreenState();
}

class _PlaylistFolderScreenState extends State<PlaylistFolderScreen> {
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 400),
              // child: Playlistfolder(foldertext: ""),
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
