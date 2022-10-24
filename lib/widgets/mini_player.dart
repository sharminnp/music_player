import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/functions/recentMostFav.dart';
import 'package:music_player/models/types.dart';
import 'package:music_player/screens/Playing_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({
    Key? key,
    required this.songList,
    required this.index,
  }) : super(key: key);
  final int index;
  final List<SongTypes> songList;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  List<Audio> songAudio = [];
  convertSongModelToAudio() {
    for (var audio in widget.songList) {
      songAudio.add(
        Audio.file(
          audio.uri,
          metas: Metas(
            id: audio.id.toString(),
            title: audio.title,
            artist: audio.artist,
          ),
        ),
      );
    }
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  void initState() {
    convertSongModelToAudio();
    super.initState();
    audioPlayer.open(
      Playlist(
        audios: songAudio,
        startIndex: widget.index,
      ),
      showNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (BuildContext context, Playing) {
      final myAudio = find(songAudio, Playing.audio.assetAudioPath);
      addSongstoRecents(id: myAudio.metas.id!, context: context);
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => PlayingScreen(
                index: widget.index,
                songList: widget.songList,
                audioPlayer: audioPlayer,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20),
              color: Color(0xffDCC6C6)),
          // height: 75,
          width: double.infinity,
          child: ListTile(
            leading: QueryArtworkWidget(
                // artworkBorder: ,
                artworkBorder: BorderRadius.circular(0),
                id: int.parse(myAudio.metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Image.asset(
                  "assets/images/images (1).jpg",
                )),
            title: Text(
              audioPlayer.getCurrentAudioTitle,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xff4a4e69),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              audioPlayer.getCurrentAudioArtist,
              maxLines: 1,
              style: TextStyle(color: Color(0xff4a4e69), fontSize: 12),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onDoubleTap: () {},
                  child: IconButton(
                      onPressed: () {
                        audioPlayer.previous();
                      },
                      icon: Icon(
                        Icons.fast_rewind_rounded,
                        size: 35,
                        color: Color(0xff3A2D43),
                      )),
                ),
                PlayerBuilder.isPlaying(
                    player: audioPlayer,
                    builder: (context, isPlaying) {
                      return IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                          } else {
                            {
                              audioPlayer.play();
                            }
                          }
                        },
                        icon: isPlaying
                            ? const Icon(
                                Icons.pause_circle,
                                size: 35,
                                color: Color(0xff3A2D43),
                              )
                            : const Icon(
                                Icons.play_circle,
                                size: 35,
                                color: Color(0xff3A2D43),
                              ),
                      );
                    }),
                InkWell(
                  onDoubleTap: () {},
                  child: IconButton(
                      onPressed: () {
                        audioPlayer.next();
                      },
                      icon: Icon(
                        Icons.fast_forward_rounded,
                        size: 35,
                        color: Color(0xff3A2D43),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
