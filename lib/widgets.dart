// import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

final Uint8List emptyImage = Uint8List(0);

const margin = EdgeInsets.symmetric(vertical: 5);
const listViewPadding = EdgeInsets.only(left: 50);
const SizedBox sizedBox = SizedBox(
  width: 10,
);
final fontAppName = GoogleFonts.lato(color: Colors.white, fontSize: 20);

showCircularProgressIndicator() {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    ),
  );
}

Widget primaryTile(String tileName) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.red,
      child: Center(
        child: Text(
          tileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ),
  );
}

///////////////////////////////////////////////////////
fragmentMemoryImageWidget(Uint8List image, double size) {
  return Image(
    image: MemoryImage(image),
    width: size,
  );
}

fragmentAppName(String appName) {
  return Flexible(
    child: Text(
      appName,
      style: fontAppName,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

buildBottomBar() {
  return Container(
    // color: Colors.red,
    height: 50,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.phone,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.chrome,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.camera,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.cog,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "19:57",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 12),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "24/08/2020",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LineAwesomeIcons.comment,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
