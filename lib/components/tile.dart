import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_apps/device_apps.dart';

Widget tile(IconData icon, String appName, String packageName, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
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
                child: Icon(
              icon,
              color: Colors.white,
              size: 45,
            )
                //      Image(
                //   image: image,
                //   width: 70,
                //   height: 70,
                // ),
                ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Text(
                "$appName",
                overflow: TextOverflow.ellipsis,
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
