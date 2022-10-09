import 'package:flutter/material.dart';
import 'package:music_player/screens/Playing_Screen.dart';
import 'package:music_player/screens/Playlist_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Searchtile(BuildContext context, String image, String songname, String artist) {
  //
  var _MediaQuery = MediaQuery.of(context);
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff4a4e69),
    ),
    // height: 70,
    width: double.infinity,
    child: ListTile(
      // contentPadding: EdgeInsets.symmetric(horizontal: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Expanded(
            child: Image.network(
          image,
          height: _MediaQuery.size.height * 0.8,
          fit: BoxFit.cover,
        )),
      ),
      title: Text(
        songname,
        style: TextStyle(
          color: Color(0xffDCC6C6),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        artist,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    ),
  );
}

// mostsongstile(BuildContext context, image, String songname, String artist) {
//   var _MediaQuery = MediaQuery.of(context);
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Color(0xff4a4e69),
//     ),
//     // height: 70,
//     width: double.infinity,
//     child: ListTile(
//       // contentPadding: EdgeInsets.symmetric(horizontal: 4),
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           image,
//           height: _MediaQuery.size.height * 0.8,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(
//         songname,
//         style: TextStyle(
//           color: Color(0xffDCC6C6),
//           fontWeight: FontWeight.w700,
//           fontSize: 16,
//         ),
//       ),
//       subtitle: Text(
//         artist,
//         style: TextStyle(color: Colors.white, fontSize: 12),
//       ),
//       trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//     ),
//   );
// }

// recentstile(
//     BuildContext context, String image, String songname, String artist) {
//   var _MediaQuery = MediaQuery.of(context);
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Color(0xff4a4e69),
//     ),
//     // height: 70,
//     width: double.infinity,
//     child: ListTile(
//       // contentPadding: EdgeInsets.symmetric(horizontal: 4),
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           image,
//           height: _MediaQuery.size.height * 0.8,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(
//         songname,
//         style: TextStyle(
//           color: Color(0xffDCC6C6),
//           fontWeight: FontWeight.w700,
//           fontSize: 16,
//         ),
//       ),
//       subtitle: Text(
//         artist,
//         style: TextStyle(color: Colors.white, fontSize: 12),
//       ),
//       trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//     ),
//   );
// }

// Favouritestile(
//     BuildContext context, String image, String songname, String artist) {
//   var _MediaQuery = MediaQuery.of(context);
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Color(0xff4a4e69),
//     ),
//     // height: 70,
//     width: double.infinity,
//     child: ListTile(
//       // contentPadding: EdgeInsets.symmetric(horizontal: 4),
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           image,
//           height: _MediaQuery.size.height * 0.8,
//           fit: BoxFit.cover,
//         ),
//       ),
//       title: Text(
//         widget.songList[widget.index].title,
//         style: TextStyle(
//           color: Color(0xffDCC6C6),
//           fontWeight: FontWeight.w700,
//           fontSize: 16,
//         ),
//       ),
//       subtitle: Text(
//         artist,
//         style: TextStyle(color: Colors.white, fontSize: 12),
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             color: Colors.white60,
//             onPressed: () {},
//             icon: Icon(Icons.playlist_add),
//           ),
//           IconButton(
//             color: Colors.white70,
//             onPressed: () {},
//             icon: Icon(Icons.favorite),
//           ),
//         ],
//       ),
//     ),
//   );
// }

folderplaylist(BuildContext context, String foldertext) {
  var _MediaQuery = MediaQuery.of(context);
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const PlaylistScreen(),
                ));
          },
          child: Container(
            height: _MediaQuery.size.height * 0.120,
            width: _MediaQuery.size.width * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff4a4e69),
            ),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      foldertext,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDCC6C6),
                      ),
                    ),
                  ),
                ),
                PopupMenuButton(
                    icon: Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white70,
                    ),
                    itemBuilder: ((context) => [
                          PopupMenuItem(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 28,
                                  ),
                                  // SizedBox(
                                  //   width: _MediaQuery.size.width * 0.03,
                                  // ),
                                  Text("Rename")
                                ],
                              ),
                              // SizedBox(
                              //   height: _MediaQuery.size.height * 0.03,
                              // ),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 28,
                                  ),
                                  // SizedBox(
                                  //   width: _MediaQuery.size.width * 0.002,
                                  // ),
                                  Text("Remove Folder")
                                ],
                              )
                            ],
                          ))
                        ])),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Playlisttile(
    BuildContext context, String image, String songname, String artist) {
  var _MediaQuery = MediaQuery.of(context);
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff4a4e69),
    ),
    // height: 70,
    width: double.infinity,
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          height: _MediaQuery.size.height * 0.8,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        songname,
        style: TextStyle(
          color: Color(0xffDCC6C6),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        artist,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      // trailing: Row(
      //   children: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.delete_rounded)),
      //     IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
      //   ],
      // ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            color: Colors.white60,
            onPressed: () {
              showAlertDialog(context);
            },
            icon: Icon(Icons.delete_rounded),
          ),
          IconButton(
            color: Colors.white70,
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  var _MediaQuery = MediaQuery.of(context);
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    // title: Text("Remove from Playlist"),
    // content: ( Text("enter Folder Name")),
    content: Text("Remove From playlist"),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Yes"))
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
