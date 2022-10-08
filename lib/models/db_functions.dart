import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_player/models/types.dart';

Box<SongTypes> getSongBox() {
  return Hive.box<SongTypes>('dbSongs');
}

Box<List> getPlaylistBox() {
  return Hive.box<List>('Playlist');
}
