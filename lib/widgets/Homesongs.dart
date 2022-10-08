import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/widgets/custom_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Homesongs extends StatefulWidget {
  Homesongs({
    Key? key,
  }) : super(key: key);

  @override
  State<Homesongs> createState() => _HomesongsState();
}

class _HomesongsState extends State<Homesongs> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  List<SongTypes>? dbSongs;
  final _auidoQuery = OnAudioQuery();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();

    dbSongs = songBox.values.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    //   return ListView.separated(
    //       itemCount: 8,
    //       separatorBuilder: (context, index) => SizedBox(
    //             height: _MediaQuery.size.height * 0.01,
    //           ),
    //       itemBuilder: (context, index) =>
    //           listtile(context, images[index], songsName[index], artist[index]));

    // return FutureBuilder<List<SongModel>>(
    //     future: _auidoQuery.querySongs(
    //         sortType: null,
    //         orderType: OrderType.ASC_OR_SMALLER,
    //         uriType: UriType.EXTERNAL,
    //         ignoreCase: true),
    //     builder: (context, item) {
    //       if (item.data == null) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (item.data!.isEmpty) {
    //         return Center(
    //           child: Text("No Songs Found"),
    //         );
    //       }
    //       return ListView.separated(
    //         separatorBuilder: (context, index) => SizedBox(
    //           height: 10,
    //         ),
    //         itemCount: item.data!.length,
    //         itemBuilder: (context, index) {
    //           return CustomListTile(
    //             context: context,
    //             songList: item.data!,
    //             index: index,
    //           );
    //         },
    //       );
    //     });
    return (dbSongs!.isEmpty)
        ? Center(
            child: Text("No songs"),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            itemCount: dbSongs!.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                context: context,
                songList: dbSongs!,
                index: index,
              );
            },
          );
  }
}
