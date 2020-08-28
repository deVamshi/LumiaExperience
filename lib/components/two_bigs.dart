// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:minimal_launcher/components/tile.dart';

// Widget twoBigsEqual(
//     IconData uint8List,
//     String appName1,
//     String packageName1,
//     Color color1,
//     IconData uint8List2,
//     String appName2,
//     String packageName2,
//     Color color2,
//   IconData uint8List3,
//     String appName3,
//     String packageName3,
//     Color color3) {
//   return Container(
//     height: 120,
//     child: Row(
//       children: [
//         Expanded(
//           child: tile(uint8List, appName1, packageName1, color1),
//         ),
//         Expanded(
//           child: tile(uint8List2, appName2, packageName2, color2),
//         ),
//         Expanded(
//           child: tile(uint8List3, appName3, packageName3, color3),
//         ),
//       ],));}
    

//  twoBigsUnEqualL(
//     IconData uint8List,
//     String appName1,
//     String packageName1,
//     Color color1,
//     IconData uint8Lis2,
//     String appName2,
//     String packageName2,
//     Color color2) {
//   return Container(
//     height: 100,
//     child: Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: tile(uint8List, appName1, packageName1, color1),
//         ),
//         Expanded(
//           child: tile(uint8Lis2, appName2, packageName2, color2),
//         ),
//       ],
//     ),
//   );
// }

// Widget twoBigsUnEqualR(
//     IconData uint8List,
//     String appName1,
//     String packageName1,
//     Color color1,
//     IconData uint8List1,
//     // String appName2,
//     String packageName2,
//     Color color2) {
//   return Container(
//     height: 100,
//     child: Row(
//       children: [
   
//         Expanded(
//           // flex: 1,
//           child: tile(uint8List, appName2, packageName2, color2),
//         ),
//         Expanded(
//           flex: 2,
//           child: tile(uint8List1, appName1, packageName1, color1),
//         ),
//       ],
//     ),
//   );
// }

//  single(
//   IconData uint8List,
//   String appName1,
//   String packageName1,
//   Color color1,
// ) {
//   return Container(
//     height: 100,
//     child: Row(
//       children: [
//         Flexible(
//           child: tile(uint8List, appName1, packageName1, color1),)
        
//         // Spacer(),
//       ],
//     ),
//   );
// }
