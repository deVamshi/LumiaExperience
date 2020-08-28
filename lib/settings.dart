import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onHorizontalDragUpdate: (dragDetail) {
              if (dragDetail.delta.dx > 0) {
                Navigator.pop(context, PageTransitionType.rightToLeft);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "settings",
                      style: GoogleFonts.lato(
                          color: Colors.white,
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
                    child: ListView(
                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 10,
                          ),
                          onTap: () {},
                          title: Text(
                            "mode",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        ListTile(
                          leading: SizedBox(
                            width: 10,
                          ),
                          onTap: () {},
                          title: Text(
                            "themes",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        ListTile(
                          leading: SizedBox(
                            width: 10,
                          ),
                          onTap: () {},
                          title: Text(
                            "fontstyle",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        ListTile(
                          leading: SizedBox(
                            width: 10,
                          ),
                          onTap: () {},
                          title: Text(
                            "feedback",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        ListTile(
                          leading: SizedBox(
                            width: 10,
                          ),
                          onTap: () {},
                          title: Text(
                            "about",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
