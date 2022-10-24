import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/functions/recentMostFav.dart';
import 'package:music_player/models/types.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/playlistList.dart';
import '../widgets/playlist_function.dart';

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

  //static void addSongstoRecents({required String id}) {}
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
                  height: _MediaQuery.size.height * 0.045,
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
                        icon: (isLoop == true)
                            ? Icon(
                                Icons.repeat,
                                color: Color(0xff3A2D43),
                                size: 30,
                              )
                            : Icon(
                                Icons.repeat_one,
                                color: Color(0xff3A2D43),
                                size: 30,
                              )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 50),
                    child: PopupMenuButton(
                        icon: Icon(
                          Icons.playlist_add,
                          color: Color(0xff3A2D43),
                          size: 30,
                        ),
                        itemBuilder: ((context) => [
                              PopupMenuItem(
                                  onTap: () {
                                    final Song = showplaylistmodelbottomsheet(
                                      songId: myAudio.metas.id!,
                                      ctx: context,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.playlist_add,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                      Text("Add to Playlist")
                                    ],
                                  )

                                  //   )        child: IconButton(
                                  //             color: Colors.white60,
                                  //             onPressed: () {},
                                  )
                            ])),
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
                // addSongstoRecents(id: myAudio.metas.id!);
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ProgressBar(
                    thumbColor: Colors.white,
                    baseBarColor: Colors.black,
                    bufferedBarColor: Colors.black45,
                    // thumbGlowColor: Colors.black,
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
                              color: Color(0xff3A2D43),
                              size: 30,
                            )
                          : Icon(
                              Icons.arrow_forward,
                              color: Color(0xff3A2D43),
                              size: 30,
                            )),
                  // SizedBox(width: _MediaQuery.size.width * 0.05),
                  InkWell(
                    onDoubleTap: () {},
                    child: IconButton(
                        onPressed: () {
                          widget.audioPlayer.previous();
                        },
                        icon: Icon(
                          Icons.fast_rewind_rounded,
                          size: 50,
                          color: Color(0xff3A2D43),
                        )),
                  ),
                  // SizedBox(
                  //   width: _MediaQuery.size.width * 0.04,
                  // ),
                  PlayerBuilder.isPlaying(
                      player: widget.audioPlayer,
                      builder: (context, isPlaying) {
                        return IconButton(
                          onPressed: () {
                            if (isPlaying) {
                              widget.audioPlayer.pause();
                            } else {
                              widget.audioPlayer.play();
                            }
                          },
                          icon: isPlaying
                              ? const Icon(
                                  Icons.pause_circle,
                                  size: 50,
                                )
                              : const Icon(
                                  Icons.play_circle,
                                  size: 50,
                                ),
                        );
                      }),
                  // SizedBox(
                  //   width: _MediaQuery.size.width * 0.04,
                  // ),
                  InkWell(
                    onDoubleTap: () {},
                    child: IconButton(
                        onPressed: () {
                          widget.audioPlayer.next();
                        },
                        icon: Icon(
                          Icons.fast_forward_rounded,
                          size: 50,
                          color: Color(0xff3A2D43),
                        )),
                  ),
                  // SizedBox(width: _MediaQuery.size.width * 0.20),
                  IconButton(
                    color: Colors.white70,
                    onPressed: () {
                      addSongstoFavourites(
                          context: context, id: myAudio.metas.id!);
                      setState(() {
                        isThisFavourite(id: myAudio.metas.id!);
                      });
                    },
                    icon: Icon(isThisFavourite(id: myAudio.metas.id!)),
                  ),
                ],
              )
            ],
          );
        }

            //
            ));
  }

  showplaylistmodelbottomsheet({
    required BuildContext ctx,
    required String songId,
  }) {
    Box<List> PlaylistBox = Hive.box<List>("Playlist");
    var _MediaQuery = MediaQuery.of(context);
    showBottomSheet(
      context: ctx,
      builder: (context) {
        return Container(
            height: _MediaQuery.size.height * 0.55,
            color: Color(0xff9C95A1),
            width: double.infinity,
            child: Column(children: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff3A2D43),
                  ),
                  onPressed: () {
                    Alertfunc.showCreatingPlaylistDialogue(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Create Playlist")),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: PlaylistBox.listenable(),
                      builder: (context, value, child) {
                        List keys = PlaylistBox.keys.toList();
                        keys.removeWhere((element) => element == 'favourites');
                        keys.removeWhere((element) => element == 'recent');
                        keys.removeWhere(
                            (element) => element == 'mostlyPlayed');

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
                                  final List<SongTypes> playlistSongList =
                                      PlaylistBox.get(playlistName)!
                                          .toList()
                                          .cast<SongTypes>();
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
}
