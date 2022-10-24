import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/widgets/textfielPlaylist.dart';

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
        builder: (BuildContext ctx) {
          final formKey = GlobalKey<FormState>();
          return Form(
              key: formKey,
              child: AlertDialog(
                title: Text('create Folder'),
                //
                content: TextFieldPlaylist(
                  hintText: "Enter folder Name",
                  textController: textEditingController,
                  validator: (value) {
                    final keys = Hive.box<List>("Playlist").keys.toList();
                    if (value == null || value.isEmpty) {
                      return "please Enter";
                    }
                    if (keys.contains(value)) {
                      return '$value Already Exist';
                    }
                    return null;
                  },
                ),
                actions: [
                  TextButton(onPressed: () {}, child: Text('close')),
                  TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await createnewplaylist();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('create'))
                ],
              ));
        });
  }

//
}
