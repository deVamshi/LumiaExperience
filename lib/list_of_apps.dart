// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:minimal_launcher/values.dart';
// import 'widgets.dart';
// // import 'main_screen.dart';
// import 'methods.dart';

// class ListOfApps extends StatelessWidget {
//   bool whichOne;
  
//   // Future<List<Application>> prepareApps() async {
//   //   List<Application> appsOrdered = await DeviceApps.getInstalledApplications(
//   //       includeAppIcons: true,
//   //       includeSystemApps: true,
//   //       onlyAppsWithLaunchIntent: true);
//   //   appsOrdered.sort((a, b) {
//   //     return a.appName.toLowerCase().compareTo(
//   //           b.appName.toLowerCase(),
//   //         );
//   //   });
//   //   return appsOrdered;
//   // }

//   @override
//   Widget build(BuildContext context) {
   
//     return Column(
//       children: [
//         SizedBox(
//           height: 50,
//         ),
//         Expanded(
//           child: Container(
//               child: FutureBuilder(
//                   future: prepareApps(),
//                   builder: (bc, data) {
//                     return data.hasData
//                         ? buildListOfApps(data.data)
//                         : Center(
//                             child: SizedBox(
//                               height: 15,
//                               width: 15,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 1,
//                                 valueColor:
//                                     AlwaysStoppedAnimation(Colors.white),
//                               ),
//                             ),
//                           );
//                   })
//               // : buildListOfApps(Values.apps),
//               ),
//         ),
//       ],
//     );
//   }
// }
