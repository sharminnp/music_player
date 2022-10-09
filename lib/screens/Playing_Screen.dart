import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/widgets/mostPlayedFunction.dart';
import 'package:music_player/widgets/recentFunction.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({
    Key? key,
    required this.songList,
    required this.index,
    required this.audioPlayer,
  }) : super(key: key);

  final List<SongTypes> songList;
  final int index;
  final AssetsAudioPlayer audioPlayer;

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  List<Audio> songAudio = [];
  bool isPlaying = true;
  bool isRepeat = true;
  bool isLoop = true;
  Color color = Colors.white;
  bool isshuffle = true;
  convertSongModelToAudio() {
    for (var audio in widget.songList) {
      songAudio.add(Audio.file(
        audio.uri,
        metas: Metas(
          id: audio.id.toString(),
          title: audio.title,
          artist: audio.artist,
        ),
      ));
    }
  }

  @override
  void initState() {
    convertSongModelToAudio();
    super.initState();
    // widget.audioPlayer.open(
    //   Playlist(
    //     audios: songAudio,
    //     startIndex: widget.index,
    //   ),
    //   showNotification: true,
    // );
  }

  static Box<SongTypes> songBox = Hive.box<SongTypes>("DbSongs");
  static Box<List> PlaylistBox = Hive.box<List>("Playlist");

  static addSongstoRecents({required String id}) async {
    List<SongTypes> dbSongs = songBox.values.toList().cast();

    final List<SongTypes> recentSongList =
        PlaylistBox.get('recent')!.toList().cast<SongTypes>();

    final SongTypes recentSong =
        dbSongs.firstWhere((song) => song.id.contains(id));
    int count = recentSong.count;
    recentSong.count = count + 1;
    log(recentSong.count.toString());
    addSongstoMostlyPlayed(id);

    if (recentSongList.length >= 10) {
      recentSongList.removeLast();
    }

    if (recentSongList.where((song) => song.id == recentSong.id).isEmpty) {
      recentSongList.insert(0, recentSong);
      await PlaylistBox.put('recent', recentSongList);
    } else {
      recentSongList.removeWhere((song) => song.id == recentSong.id);
      recentSongList.insert(0, recentSong);
      await PlaylistBox.put('recent', recentSongList);
    }
  }

  static addSongstoMostlyPlayed(String id) async {
    final mostPlayedList =
        PlaylistBox.get('mostlyPlayed')!.toList().cast<SongTypes>();
    final dbSongs = songBox.values.toList().cast<SongTypes>();
    final mostPlayedSong = dbSongs.firstWhere((song) => song.id.contains(id));
    if (mostPlayedList.length >= 10) {
      mostPlayedList.removeLast();
    }
    if (mostPlayedSong.count >= 3) {
      if (mostPlayedList
          .where((song) => song.id == mostPlayedSong.id)
          .isEmpty) {
        mostPlayedList.insert(0, mostPlayedSong);
        await PlaylistBox.put('mostlyPlayed', mostPlayedList);
      } else {
        mostPlayedList.removeWhere((song) => song.id == mostPlayedSong.id);
        mostPlayedList.insert(0, mostPlayedSong);
        await PlaylistBox.put('mostlyPlayed', mostPlayedList);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Color(0xff9C95A1),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 40,
                color: Colors.black,
              )),
          backgroundColor: Color(0xff9C95A1),
          title: Text(
            "Playing Now",
            style: TextStyle(color: Color(0xff3A2D43)),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: widget.audioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
          final myAudio = find(songAudio, playing!.audio.assetAudioPath);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Container(
                  height: _MediaQuery.size.height * 0.35,
                  width: _MediaQuery.size.width * 0.70,
                  child: QueryArtworkWidget(
                      // artworkBorder: ,
                      id: int.parse(myAudio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget:
                          Image.asset("assets/images/images (1).jpg")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 25,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Marquee(
                      text: widget.audioPlayer.getCurrentAudioTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black45),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 20.0,
                      velocity: 30.0,
                      // pauseAfterRound: Duration(seconds: 1),
                      startPadding: 10.0,
                    ),
                  ),
                ),
                // child: Text(
                //   audioPlayer.getCurrentAudioTitle,
                //   maxLines: 1,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 23,
                //       fontWeight: FontWeight.w800),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  widget.audioPlayer.getCurrentAudioArtist,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 15),
                    child: IconButton(
                        onPressed: () {
                          if (isLoop == true) {
                            widget.audioPlayer.setLoopMode(LoopMode.single);
                          } else {
                            widget.audioPlayer.setLoopMode(LoopMode.playlist);
                          }
                          setState(() {
                            isLoop = !isLoop;
                          });
                        },
                        icon: Icon(
                          Icons.repeat,
                          size: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 50),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.playlist_add_rounded,
                          size: 30,
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                //
              ),

              widget.audioPlayer.builderRealtimePlayingInfos(
                  builder: (context, info) {
                addSongstoRecents(id: myAudio.metas.id!);
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ProgressBar(
                    thumbColor: Colors.white,
                    baseBarColor: Colors.black,
                    bufferedBarColor: Colors.black45,
                    thumbGlowColor: Colors.black,
                    progressBarColor: Colors.white,
                    timeLabelTextStyle: TextStyle(color: Colors.white),
                    progress: info.currentPosition,
                    total: info.duration,
                    onSeek: (newPosition) {
                      widget.audioPlayer.seek(newPosition);
                    },
                  ),
                );
              }),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.audioPlayer.toggleShuffle();
                          isshuffle = !isshuffle;
                        });
                      },
                      icon: (isshuffle == true)
                          ? Icon(
                              Icons.shuffle,
                              size: 30,
                            )
                          : Icon(
                              Icons.arrow_forward,
                              size: 30,
                            )),
                  // SizedBox(width: _MediaQuery.size.width * 0.05),
                  IconButton(
                      onPressed: () {
                        widget.audioPlayer.previous();
                      },
                      icon: Icon(
                        Icons.fast_rewind_rounded,
                        size: 50,
                        color: Color(0xff3A2D43),
                      )),
                  // SizedBox(
                  //   width: _MediaQuery.size.width * 0.04,
                  // ),
                  IconButton(
                    onPressed: () {
                      if (isPlaying == true) {
                        widget.audioPlayer.pause();

                        setState(() {
                          isPlaying = false;
                        });
                      } else if (isPlaying == false) {
                        widget.audioPlayer.play();
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    icon: isPlaying == true
                        ? Icon(
                            Icons.pause_circle,
                            size: 50,
                          )
                        : Icon(
                            Icons.play_circle,
                            size: 50,
                          ),
                  ),
                  // SizedBox(
                  //   width: _MediaQuery.size.width * 0.04,
                  // ),
                  IconButton(
                      onPressed: () {
                        widget.audioPlayer.next();
                      },
                      icon: Icon(
                        Icons.fast_forward_rounded,
                        size: 50,
                        color: Color(0xff3A2D43),
                      )),
                  // SizedBox(width: _MediaQuery.size.width * 0.20),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          );
        }

            // Column(
            //   children: [
            //     Container(
            //       height: _MediaQuery.size.height * 0.50,
            //       width: _MediaQuery.size.width * 0.70,
            //       child: Image.network(
            //           "https://a10.gaanacdn.com/gn_img/albums/mGjKrP1W6z/jKrPvDqVW6/size_l.jpg"),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 10,
            //       ),
            //       child: Text(
            //         widget.songList[widget.index].displayNameWOExt,
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 23,
            //             fontWeight: FontWeight.w800),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 10,
            //       ),
            //       child: Text(
            //         widget.songList[widget.index].artist!,
            //         style: TextStyle(
            //             color: Colors.white70,
            //             fontSize: 15,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(top: 50, left: 15),
            //           child: IconButton(
            //               onPressed: () {
            //                 if (isLoop == true) {
            //                   audioPlayer.setLoopMode(LoopMode.single);
            //                 } else {
            //                   audioPlayer.setLoopMode(LoopMode.playlist);
            //                 }
            //                 setState(() {
            //                   isLoop = !isLoop;
            //                 });
            //               },
            //               icon: Icon(
            //                 Icons.repeat,
            //                 size: 30,
            //               )),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(right: 15, top: 50),
            //           child: IconButton(
            //               onPressed: () {},
            //               icon: Icon(
            //                 Icons.playlist_add_rounded,
            //                 size: 30,
            //               )),
            //         )
            //       ],
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 15,
            //       ),
            //       //
            //     ),

            //     audioPlayer.builderRealtimePlayingInfos(builder: (context, info) {
            //       return Padding(
            //         padding: const EdgeInsets.only(left: 20, right: 20),
            //         child: ProgressBar(
            //           thumbColor: Colors.white,
            //           baseBarColor: Colors.black,
            //           bufferedBarColor: Colors.black45,
            //           thumbGlowColor: Colors.black,
            //           progressBarColor: Colors.white,
            //           timeLabelTextStyle: TextStyle(color: Colors.white),
            //           progress: info.currentPosition,
            //           total: info.duration,
            //           onSeek: (newPosition) {
            //             audioPlayer.seek(newPosition);
            //           },
            //         ),
            //       );
            //     }),

            //     //
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         IconButton(
            //             onPressed: () {},
            //             icon: Icon(
            //               Icons.shuffle,
            //               size: 30,
            //             )),
            //         SizedBox(width: _MediaQuery.size.width * 0.13),
            //         IconButton(
            //             onPressed: () {
            //               audioPlayer.previous();
            //             },
            //             icon: Icon(
            //               Icons.fast_rewind_rounded,
            //               size: 50,
            //               color: Color(0xff3A2D43),
            //             )),

            //         IconButton(
            //           onPressed: () {
            //             if (isPlaying == true) {
            //               audioPlayer.pause();

            //               setState(() {
            //                 isPlaying = false;
            //               });
            //             } else if (isPlaying == false) {
            //               audioPlayer.play();
            //               setState(() {
            //                 isPlaying = true;
            //               });
            //             }
            //           },
            //           icon: isPlaying == true
            //               ? Icon(
            //                   Icons.pause_circle,
            //                   size: 50,
            //                 )
            //               : Icon(
            //                   Icons.play_circle,
            //                   size: 50,
            //                 ),
            //         ),
            //         IconButton(
            //             onPressed: () {
            //               audioPlayer.next();
            //             },
            //             icon: Icon(
            //               Icons.fast_forward_rounded,
            //               size: 50,
            //               color: Color(0xff3A2D43),
            //             )),
            //         SizedBox(width: _MediaQuery.size.width * 0.17),
            //         IconButton(
            //             onPressed: () {},
            //             icon: Icon(
            //               Icons.favorite,
            //               size: 30,
            //               color: Colors.white,
            //             )),
            //       ],
            //     )
            //   ],
            // ),
            ));
  }
}
