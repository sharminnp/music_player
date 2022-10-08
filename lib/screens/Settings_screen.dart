import 'package:flutter/material.dart';
import 'package:music_player/widgets/common.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9C95A1),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff3A2D43),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff9C95A1),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                //
                settingslist(text: "Theme Switch", icons: (Icons.toggle_off)),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                ),
                settingslist(
                    text: "Terms and Condition",
                    icons: (Icons.keyboard_arrow_right)),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                ),
                settingslist(
                    text: "Privacy policy",
                    icons: (Icons.keyboard_arrow_right)),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                ),
                settingslist(
                    text: "About", icons: (Icons.keyboard_arrow_right)),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
          // miniplayertile(
          //   context,
          //   "https://a10.gaanacdn.com/gn_img/albums/mGjKrP1W6z/jKrPvDqVW6/size_l.jpg",
          //   'Always',
          //   'Isak Danielson',
          // ),
        ],
      ),
    );
  }
}

Widget settingslist({required text, required IconData icons}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff4a4e69),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          icons,
          size: 50,
          color: Color(0xff3A2D43),
        ),
      ),
    ],
  );
}
