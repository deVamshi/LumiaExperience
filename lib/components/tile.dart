import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_apps/device_apps.dart';
import 'package:minimal_launcher/widgets.dart';

Widget tile(
    Uint8List uint8list, String appName, String packageName, Color color, double size) {
  return Container(
    // width: 100,
    // height: 50,
    // color: Colors.red,
    padding: EdgeInsets.all(3),
    // margin: EdgeInsets.symmetric(horizontal: 5,),
    child: GestureDetector(
      onTap: () {
        DeviceApps.openApp(packageName);
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        color: color,
        child: Stack(
          children: [
            Center(
                child:
                //  CircleAvatar(
            //       radius: size,
            //   backgroundImage: MemoryImage(uint8list),
            //   backgroundColor: Colors.blue,
            // )
                //  Icon(uint8list,color: Colors.white,size: 40,)
                fragmentMemoryImageWidget(uint8list, size),
                ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Text(
                "$appName",
                overflow: TextOverflow.fade,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
