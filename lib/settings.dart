import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_launcher/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/action.dart' as android_action;

class Settings extends StatelessWidget {
  final sizedBox = SizedBox(
    height: 5,
  );

  showSimpleDialog(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      children: [
        colorPallette(context, "lightBlue", 0, Colors.lightBlue[200],
            Colors.lightBlue[300], Colors.lightBlue[400], Colors.lightBlue),
        sizedBox,
        colorPallette(context, "green", 1, Colors.green[200], Colors.green[300],
            Colors.green[400], Colors.green),
        sizedBox,
        colorPallette(context, "teal", 2, Colors.teal[200], Colors.teal[300],
            Colors.teal[400], Colors.teal),
        sizedBox,
        colorPallette(context, "amber", 3, Colors.amber[200], Colors.amber[300],
            Colors.amber[400], Colors.amber),
        sizedBox,
        colorPallette(context, "pink", 4, Colors.pink[200], Colors.pink[300],
            Colors.pink[400], Colors.pink),
        sizedBox,
        colorPallette(context, "red", 5, Colors.red[200], Colors.red[300],
            Colors.red[400], Colors.red),
        sizedBox,
        colorPallette(context, "blue", 6, Colors.blue[200], Colors.blue[300],
            Colors.blue[400], Colors.blue),
        sizedBox,
        colorPallette(context, "indigo", 7, Colors.indigo[200],
            Colors.indigo[300], Colors.indigo[400], Colors.indigo),
      ],
    );
  }

  colorPallette(BuildContext context, String palletteName, int themeIndex,
      Color color1, Color color2, Color color3, Color color4) {
    return Container(
      height: 50,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, themeIndex);
        },
        child: Card(
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    color: color1,
                  )),
                  Expanded(
                      child: Container(
                    color: color2,
                  )),
                  Expanded(
                      child: Container(
                    color: color3,
                  )),
                  Expanded(
                      child: Container(
                    color: color4,
                  )),
                ],
              ),
              Positioned(
                bottom: 2,
                left: 5,
                child: Text(
                  palletteName,
                  style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  settingsFragment(BuildContext context, String title, String value) {
    return ListTile(
      leading: SizedBox(),
      onTap: () async {
        if (title == "theme") {
          await showDialog(
              context: context,
              builder: (context) {
                return showSimpleDialog(context);
              }).then((value) {
            if (value != null) {
              int themeIndex = value;
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(themeIndex);
            }
            return;
          });
        }
        if (value == "feedback") {
          android_intent.Intent()
            ..setAction(android_action.Action.ACTION_VIEW)
            ..setData(Uri(scheme: "mailto", path: "dev.vamshidhar@gmail.com"))
            ..startActivity().catchError((e) => print(e));
        }
      },
      title: Text(
        "$title",
        style: GoogleFonts.lato(
            color: Colors.red[400], fontSize: 12, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "$value",
        style: GoogleFonts.lato(
            color: Colors.grey[300], fontSize: 40, fontWeight: FontWeight.w300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onHorizontalDragUpdate: (dragDetail) {
              if (dragDetail.delta.dx > 0) {
                Navigator.pop(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "settings",
                      style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 60,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    child: Consumer<ThemeProvider>(
                      builder: (bc, data, child) {
                        return ListView(
                          children: [
                            settingsFragment(context, "mode", "dark"),
                            settingsFragment(context, "theme", data.themeName),
                            settingsFragment(
                                context, "make this app better", "feedback"),
                            settingsFragment(context, "why this app", "about"),
                            settingsFragment(context, "about", "dark"),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
