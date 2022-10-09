// // import 'package:assets_audio_player/assets_audio_player.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:hive_flutter/adapters.dart';
// // import 'package:music_player/models/types.dart';
// // import 'package:music_player/widgets/mostPlayedFunction.dart';
// // import 'package:on_audio_query/on_audio_query.dart';

// // class MostPlayed extends StatefulWidget {
// //   const MostPlayed({Key? key}) : super(key: key);

// //   @override
// //   State<MostPlayed> createState() => _MostPlayedState();
// // }

// // class _MostPlayedState extends State<MostPlayed> {
// //   Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
// //   final _auidoQuery = OnAudioQuery();
// //   final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();
// //   Box<List> PlaylistBox = Hive.box<List>("Playlist");
// //   List<SongTypes>? mostplayedSong;
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     mostplayedSong =
// //         PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var _MediaQuery = MediaQuery.of(context);
// //     return ValueListenableBuilder(
// //         valueListenable: PlaylistBox.listenable(),
// //         builder: (BuildContext context, Box<List> value, Widget? child) {
// //           List<SongTypes> songList =
// //               PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
// //           return (songList.isEmpty)
// //               ? const Center(
// //                   child: const Text("No mostly played songs"),
// //                 )
// //               : ListView.separated(
// //                   separatorBuilder: ((context, index) => const SizedBox(
// //                         height: 5,
// //                       )),
// //                   itemCount: songList.length,
// //                   itemBuilder: (context, index) {
// //                     return MostPlayedFunction(
// //                         context: context, songList: songList, index: index);
// //                   });
// //         });
// //   }
// // }

// //     // var _MediaQuery = MediaQuery.of(context);
// //     // return ListView.separated(
// //     //     itemCount: 10,
// //     //     separatorBuilder: (context, index) => SizedBox(
// //     //           height: _MediaQuery.size.height * 0.01,
// //     //         ),
// //     //     itemBuilder: (context, index) => allsongstile(
// //     //         context, images[index], songsName[index], artist[index]));

// import 'package:flutter/cupertino.dart';

// import 'package:hive_flutter/adapters.dart';

// import 'package:music_player/widgets/mostPlayedFunction.dart';

// import '../models/types.dart';

// // class MostPlayedSongs extends StatefulWidget {
// //   const RecentSongs({Key? key}) : super(key: key);

// //   @override
// //   State<RecentSongs> createState() => _RecentSongsState();
// // }

// // class _RecentSongsState extends State<RecentSongs> {
// //   Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
// //   final _auidoQuery = OnAudioQuery();
// //   final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

// //   Box<List> PlaylistBox = Hive.box<List>("Playlist");
// //   List<SongTypes>? mostPlayedSong;
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     mostPlayedSong =
// //         PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var _MediaQuery = MediaQuery.of(context);

// //     return ValueListenableBuilder(
// //         valueListenable: PlaylistBox.listenable(),
// //         builder: (BuildContext context, Box<List> value, Widget? child) {
// //           List<SongTypes> songList =
// //               PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
// //           return (songList.isEmpty)
// //               ? Center(
// //                   child: Text("No most played songs"),
// //                 )
// //               : ListView.separated(
// //                   separatorBuilder: ((context, index) => SizedBox(
// //                         height: 5,
// //                       )),
// //                   itemCount: songList.length,
// //                   itemBuilder: (context, index) {
// //                     return MostPlayedFunction(
// //                         context: context, songList: songList, index: index);
// //                   },
// //                 );
// //         });
// //   }
// // }
// class MostPlayed extends StatefulWidget {
//   const MostPlayed({Key? key}) : super(key: key);

//   @override
//   State<MostPlayed> createState() => _MostPlayedState();
// }

// class _MostPlayedState extends State<MostPlayed> {
//   Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");

//   Box<List> PlaylistBox = Hive.box<List>("Playlist");
//   List<SongTypes>? mostSong;
//   @override
//   void initState() {
//     // TODO: implement initState
//     mostSong = PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: PlaylistBox.listenable(),
//         builder: (BuildContext context, Box<List> value, Widget? child) {
//           List<SongTypes> songList =
//               PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
//           return (songList.isEmpty)
//               ? Center(
//                   child: Text("No most played songs"),
//                 )
//               : ListView.separated(
//                   separatorBuilder: ((context, index) => SizedBox(
//                         height: 5,
//                       )),
//                   itemCount: songList.length,
//                   itemBuilder: (context, index) {
//                     return MostPlayedFunction(
//                         context: context, songList: songList, index: index);
//                   },
//                 );
//         });
//   }
// }

import 'package:flutter/widgets.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/widgets/mostPlayedFunction.dart';

import '../models/types.dart';

class mostPlayedWidget extends StatefulWidget {
  const mostPlayedWidget({Key? key}) : super(key: key);

  @override
  State<mostPlayedWidget> createState() => _mostPlayedWidgetState();
}

class _mostPlayedWidgetState extends State<mostPlayedWidget> {
  Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");

  Box<List> PlaylistBox = Hive.box<List>("Playlist");
  List<dynamic>? mostSong;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostSong = PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return ValueListenableBuilder(
        valueListenable: PlaylistBox.listenable(),
        builder: (BuildContext context, Box<List> value, Widget? child) {
          List<SongTypes> songList =
              PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
          return (songList.isEmpty)
              ? Center(
                  child: Text("No Mostplayed songs"),
                )
              : ListView.separated(
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 5,
                      )),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return mostPlayed(
                        context: context, songList: songList, index: index);
                  },
                );
        });
  }
}
