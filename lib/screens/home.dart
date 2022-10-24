import 'package:flutter/material.dart';
import 'package:music_player/screens/Favourite_Screen.dart';
import 'package:music_player/screens/MostPlayedSong_screen.dart';
import 'package:music_player/screens/PlaylistFolder_Screen.dart';
import 'package:music_player/screens/Recents_Screen.dart';
import 'package:music_player/screens/Settings_screen.dart';

import 'package:music_player/screens/searchscreen.dart';
import 'package:music_player/widgets/Homesongs.dart';
import 'package:music_player/widgets/mini_player.dart';

import '../models/types.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get itemBuilder => null;
  bool isMiniplayerVisible = false;

  @override
  Widget build(BuildContext context) {
    var _MediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff9C95A1),
      body: Builder(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          "TAKE A CHILL PILL",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff3A2D43),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SearchScreen();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.search)),
                          // IconButton(
                          //   onPressed: () {},
                          // icon: Icon(Icons.playlist_add),
                          // ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SettingsScreen()));
                              },
                              icon: Icon(Icons.settings))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => PlaylistFolderScreen()));
                          },
                          child: Container(
                            height: _MediaQuery.size.height * 0.08,
                            width: _MediaQuery.size.width * 0.43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Color(0xff4a4e69),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 52, top: 20),
                              child: Text(
                                "Playlist",
                                style: TextStyle(
                                    color: Color(0xffDCC6C6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => FavouriteScreen()));
                          },
                          child: Container(
                            height: _MediaQuery.size.height * 0.08,
                            width: _MediaQuery.size.width * 0.43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Color(0xff4a4e69),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 45, top: 20),
                              child: Text(
                                "Favourites",
                                style: TextStyle(
                                    color: Color(0xffDCC6C6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => MostPlayedSongsScreen()));
                          },
                          child: Container(
                            height: _MediaQuery.size.height * 0.08,
                            width: _MediaQuery.size.width * 0.43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Color(0xff4a4e69),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 30, top: 23),
                              child: Text(
                                "Mostly Played",
                                style: TextStyle(
                                    color: Color(0xffDCC6C6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => RecentsScreen()));
                          },
                          child: Container(
                            height: _MediaQuery.size.height * 0.08,
                            width: _MediaQuery.size.width * 0.43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Color(0xff4a4e69),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20, top: 23),
                              child: Text(
                                "Recently Played",
                                style: TextStyle(
                                    color: Color(0xffDCC6C6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 250,
                      top: 17,
                    ),
                    child: Text(
                      "All Songs",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff3A2D43),
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 13,
                  right: 13,
                  top: 10,
                ),
                child: Homesongs(context: context),
              ),
            ),
          ],
        );
      }),
    ));
  }
}
