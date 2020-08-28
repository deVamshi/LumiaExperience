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

// Widget secondaryTile(InstalledAppModel app) {
//   return ListTile(
//     onTap: () async {
//       await DeviceApps.openApp(app.packageName);
//       // Future.delayed(Duration(milliseconds: 1000), () {
//       //   if (textEditingController.value != null) {
//       //     textEditingController.clear();
//       //     data.setSearchedApps(data.getProviderInstalledApps);
//       //   }
//       // });
//     },
//     leading: fragmentMemoryImageWidget(appsInListView[index].appIcon),
//     title: Text(
//       "${appsInListView[index].appName}",
//       style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
//     ),
//   );
// }

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
fragmentMemoryImageWidget(Uint8List image,double size) {
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

// buildMainApps() {
//   List<String> favoriteApps = [
//     "first",
//     "second",
//     "third",
//     "fourth",
//     "first",
//     "second",
//     "third",
//     "fourth",
//     "fifth"
//   ];

//   List<int> listOfSeries;
//   getList(List<int> list) {
//     listOfSeries = list;
//   }

//   int calculateItemCount(int length) {
//     int noOfDoubleTile = 0;
//     int noOfThribleTile = 0;
//     int noOfSingleTiles = 0;
//     int gotLength = length;
//     List<int> list = [];
//     while (gotLength > 0) {
//       if (gotLength >= 2) {
//         gotLength -= 2;
//         noOfDoubleTile += 1;
//         // gotLength % 2 == 0 ? list.add(-2) : list.add(2);
//         list.add(2);
//       }
//       if (gotLength == 1) {
//         noOfSingleTiles += 1;
//         gotLength -= 1;
//         list.add(1);
//       }

//       if (gotLength >= 3) {
//         gotLength -= 3;
//         noOfThribleTile += 1;
//         list.add(3);
//       }
//       if (gotLength == 2) {
//         noOfDoubleTile += 1;
//         gotLength -= 2;
//         list.add(2);
//       }
//       if (gotLength == 1) {
//         noOfSingleTiles += 1;
//         gotLength -= 1;
//         list.add(1);
//       }
//     }
//     getList(list);
//     // print(list);
//     // print("singleTiles $noOfSingleTiles");
//     // print("noOfDouble Tiles $noOfDoubleTile");
//     // print("noOfThribleTile  $noOfThribleTile");
//     // print(noOfSingleTiles + noOfDoubleTile + noOfThribleTile);
//     return noOfSingleTiles + noOfDoubleTile + noOfThribleTile;
//   }

//   return Container(
//     child:
//         //  Consumer<InstalledAppsProvider>(
//         //   builder: (bc, data, _) {
//         //     List<InstalledAppModel> installedAppsInMainListView =
//         //         (data.getAppsToShow == null)
//         //             ? data.getProviderInstalledApps
//         //             : data.getAppsToShow;
//         //     return ListView.builder(
//         //       padding: EdgeInsets.symmetric(horizontal: 10),
//         //       physics:
//         //           AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//         //       itemCount: 23,
//         //       itemBuilder: (BuildContext bc, int index) {
//         //         // bool isEven = index % 2 == 0;
//         //         // Widget widgetToShow;
//         //         // switch (listOfSeries[index]) {
//         //         //   case 2:
//         //         //     {
//         //         //       widgetToShow = widgetToShow = twoBigsUnEqualL(
//         //         //         installedAppsInMainListView[index * 2].appIcon,
//         //         //         installedAppsInMainListView[index * 2].appName,
//         //         //         installedAppsInMainListView[index * 2].packageName,
//         //         //         Colors.red[400],
//         //         //         installedAppsInMainListView[index * 2 + 1].appIcon,
//         //         //         installedAppsInMainListView[index * 2 + 1].appName,
//         //         //         installedAppsInMainListView[index * 2  + 1].packageName,
//         //         //         Colors.orange[400],
//         //         //       );
//         //         //       break;
//         //         //     }
//         //         //   case 3:
//         //         //     {
//         //         //       widgetToShow = twoBigsEqual(
//         //         //           installedAppsInMainListView[index * 3 + 1].appIcon,
//         //         //           installedAppsInMainListView[index * 3 + 1].appName,
//         //         //           installedAppsInMainListView[index * 3 + 1].packageName,
//         //         //           Colors.blue[400],
//         //         //           installedAppsInMainListView[index * 3 + 2].appIcon,
//         //         //           installedAppsInMainListView[index * 3 + 2].appName,
//         //         //           installedAppsInMainListView[index * 3 + 2].packageName,
//         //         //           Colors.blue[400],
//         //         //           installedAppsInMainListView[index * 3 + 3].appIcon,
//         //         //           installedAppsInMainListView[index * 3 + 3].appName,
//         //         //           installedAppsInMainListView[index  * 3+ 3].packageName,
//         //         //           Colors.blue[400]);
//         //         //       break;
//         //         //     }
//         //         //   // case -2:
//         //         //   //   {
//         //         //   //     widgetToShow = twoBigsUnEqualR(
//         //         //   //       installedAppsInMainListView[index  + 4].appIcon,
//         //         //   //       installedAppsInMainListView[index + 4].appName,
//         //         //   //       installedAppsInMainListView[index + 4].packageName,
//         //         //   //       Colors.red[400],
//         //         //   //       installedAppsInMainListView[index + 5].appIcon,
//         //         //   //       installedAppsInMainListView[index + 5].appName,
//         //         //   //       installedAppsInMainListView[index + 5].packageName,
//         //         //   //       Colors.orange[400],
//         //         //   //     );
//         //         //   //     break;
//         //         //   //   }
//         //         //   default:
//         //         //     {
//         //         //       widgetToShow = single(
//         //         //           installedAppsInMainListView[index].appIcon,
//         //         //           installedAppsInMainListView[index].appName,
//         //         //           installedAppsInMainListView[index].packageName,
//         //         //           Colors.orange[400]);
//         //         //     }
//         //         // }
//         //         return twoBigsEqual(
//         //             LineAwesomeIcons.phone,
//         //             "Phone",
//         //             "fjdsjf",
//         //             Colors.blue[400],
//         //             LineAwesomeIcons.image,
//         //             "Gallery",
//         //             "fjdsjf",
//         //             Colors.red[400],
//         //             LineAwesomeIcons.sms,
//         //             "Message",
//         //             "fjdsjf",
//         //             Colors.yellow[400]);
//         //         // ListTile(
//         //         //   title: Text(
//         //         // "In a list tile",
//         //         // style: TextStyle(color: Colors.white),
//         //         //   ),
//         //         // );
//         //       },
//         //       // childrenDelegate: SliverChildListDelegate.fixed(children)
//         //     );
//         //   },
//         //   // child:
//         // ),

//         ListView(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       physics: AlwaysScrollableScrollPhysics(
//         parent: BouncingScrollPhysics(),
//       ),
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         twoBigsUnEqualL(
//           LineAwesomeIcons.envelope_open,
//           "Gmail",
//           "fjdsjf",
//           Colors.red[400],
//           LineAwesomeIcons.headphones,
//           "Music",
//           "fjdsjf",
//           Colors.orange[400],
//         ),
//         twoBigsEqual(
//             LineAwesomeIcons.phone,
//             "Phone",
//             "fjdsjf",
//             Colors.blue[400],
//             LineAwesomeIcons.image,
//             "Gallery",
//             "fjdsjf",
//             Colors.blue[400],
//             LineAwesomeIcons.sms,
//             "Message",
//             "fjdsjf",
//             Colors.blue[400]),
//         twoBigsUnEqualR(
//             LineAwesomeIcons.calendar,
//             "Calender",
//             "chrome",
//             Colors.blue[400],
//             LineAwesomeIcons.youtube,
//             "YouTube",
//             "play store",
//             Colors.red[400]),
//         twoBigsEqual(
//           LineAwesomeIcons.google_play,
//           "Play Store",
//           "fjdsjf",
//           Colors.green[400],
//           LineAwesomeIcons.chrome,
//           "Chrome",
//           "fjdsjf",
//           Colors.blue[400],
//           LineAwesomeIcons.camera,
//           "Camera",
//           "fjdsjf",
//           Colors.purple[400],
//         ),
//       ],
//     ),
//   );
// }
