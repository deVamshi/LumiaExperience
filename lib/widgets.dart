import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'components/two_bigs.dart';
import 'Models/app_model.dart';

final Uint8List emptyImage = Uint8List(0);

const margin = EdgeInsets.symmetric(vertical: 5);
const listViewPadding = EdgeInsets.only(left: 50);
const SizedBox sizedBox = SizedBox(
  width: 10,
);
final fontAppName = GoogleFonts.lato(color: Colors.white, fontSize: 20);

// loadingApps() {
//   return ListTile(
//     leading: SizedBox(
//         width: 20,
//         height: 20,
//         child: CircularProgressIndicator(
//           strokeWidth: 1,
//           valueColor: AlwaysStoppedAnimation(Colors.grey),
//         )),
//     title: Text(
//       "Loading apps...",
//       style: fontAppName,
//     ),
//   );
// }

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

// primaryTile(Application app) {
//   return Column(
//     children: [
//       ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.red,
//           child: Center(
//             child: Text(
//               app.appName[0],
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.lato(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//           ),
//         ),
//       ),
//       secondaryTile(app)
//     ],
//   );
// }

///////////////////////////////////////////////////////
fragmentMemoryImageWidget(Uint8List image) {
  return Image(
    image: MemoryImage(image),
    width: 40,
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
            LineAwesomeIcons.cog,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "12:03 PM",
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

buildMainApps() {
  return Container(
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        SizedBox(
          height: 10,
        ),
        twoBigsUnEqualL(
          LineAwesomeIcons.envelope_open,
          "Gmail",
          "fjdsjf",
          Colors.red[400],
          LineAwesomeIcons.headphones,
          "Music",
          "fjdsjf",
          Colors.orange[400],
        ),
        twoBigsEqual(
            LineAwesomeIcons.phone,
            "Phone",
            "fjdsjf",
            Colors.blue[400],
            LineAwesomeIcons.image,
            "Gallery",
            "fjdsjf",
            Colors.blue[400],
            LineAwesomeIcons.sms,
            "Message",
            "fjdsjf",
            Colors.blue[400]),
        twoBigsUnEqualR(
            LineAwesomeIcons.calendar,
            "Calender",
            "chrome",
            Colors.blue[400],
            LineAwesomeIcons.youtube,
            "YouTube",
            "play store",
            Colors.red[400]),
        twoBigsEqual(
          LineAwesomeIcons.google_play,
          "Play Store",
          "fjdsjf",
          Colors.green[400],
          LineAwesomeIcons.chrome,
          "Chrome",
          "fjdsjf",
          Colors.blue[400],
          LineAwesomeIcons.camera,
          "Camera",
          "fjdsjf",
          Colors.purple[400],
        ),
      ],
    ),
  );
}
