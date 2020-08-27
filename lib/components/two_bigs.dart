import 'package:flutter/material.dart';
import 'package:minimal_launcher/components/tile.dart';

Widget twoBigsEqual(
    IconData iconData1,
    String appName1,
    String packageName1,
    Color color1,
    IconData iconData2,
    String appName2,
    String packageName2,
    Color color2,
    IconData iconData3,
    String appName3,
    String packageName3,
    Color color3) {
  return Container(
    height: 120,
    child: Row(
      children: [
        Expanded(
          child: tile(iconData1, appName1, packageName1, color1),
        ),
        Expanded(
          child: tile(iconData2, appName2, packageName2, color2),
        ),
        Expanded(
          child: tile(iconData3, appName3, packageName3, color3),
        ),
      ],
    ),
  );
}

Widget twoBigsUnEqualL(
    IconData iconData1,
    String appName1,
    String packageName1,
    Color color1,
    IconData iconData2,
    String appName2,
    String packageName2,
    Color color2) {
  return Container(
    height: 100,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: tile(iconData1, appName1, packageName1, color1),
        ),
        Expanded(
          child: tile(iconData2, appName2, packageName2, color2),
        ),
      ],
    ),
  );
}

Widget twoBigsUnEqualR(
    IconData iconData1,
    String appName1,
    String packageName1,
    Color color1,
    IconData iconData2,
    String appName2,
    String packageName2,
    Color color2) {
  return Container(
    height: 100,
    child: Row(
      children: [
        Expanded(
          child: tile(iconData1, appName1, packageName1, color1),
        ),
        Expanded(
          flex: 2,
          child: tile(iconData2, appName2, packageName2, color2),
        ),
      ],
    ),
  );
}
