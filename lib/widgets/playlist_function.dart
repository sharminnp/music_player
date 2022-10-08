import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/models/types.dart';

class Alertfunc {
  static showCreatingPlaylistDialogue(context) {
    TextEditingController textEditingController = TextEditingController();
    Box<List> PlaylistBox = Hive.box<List>("Playlist");
    Future<void> createnewplaylist() async {
      // List<SongTypes> songList = [];
      final String playlistName = textEditingController.text.trim();
      List<SongTypes> songList = [];
      if (playlistName.isEmpty) {
        print('<<<<<<<<<<<<<<< empty <<<<<<<<<<<<<');
        return;
      } else {
        print('>>>>>>>>>>>>>> called >>>>>>>>>>>>>>>');
        await PlaylistBox.put(playlistName, songList);
      }
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('create Folder'),
              content: TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "Enter Folder Name"),
              ),
              actions: [
                TextButton(onPressed: () {}, child: Text('close')),
                TextButton(
                    onPressed: () {},
                    //async {
                    //   List<SongTypes> songList = [];
                    //   final String playlistName =
                    //       textEditingController.text.trim();
                    //   if (playlistName.isEmpty) {
                    //     return;
                    //   } else {
                    //     await PlaylistBox.put(playlistName, songList);
                    //   }
                    // },
                    child: Text('create'))
              ],
            ));

    // showAlertDialog(BuildContext context) {
    //   // Create button
    //   Widget okButton = ElevatedButton(
    //     child: Text("OK"),
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //   );

    // Create AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("Create Folder"),
    //   // content: ( Text("enter Folder Name")),
    //   content:
    //       TextField(decoration: InputDecoration(hintText: "Enter Folder Name")),
    //   // actions: [
    //   //   okButton,
    //   // ],
    // );

    // // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
    // }
  }
}
