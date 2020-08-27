// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';
// import 'package:minimal_launcher/components/two_bigs.dart';

// class HomePage extends StatelessWidget {
//   int currentAppNumber = 0;
//   List<Application> apps = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<List<Application>>(
//           future: DeviceApps.getInstalledApplications(
//                   onlyAppsWithLaunchIntent: true,
//                   includeSystemApps: true,
//                   includeAppIcons: true)
//               .then((value) => apps = value),
//           builder: (BuildContext bc, AsyncSnapshot<List<Application>> data) {
//             if (data.data == null) {
//               return Center(
//                 child: SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation(Colors.white),
//                     strokeWidth: 2.5,
//                   ),
//                 ),
//               );
//             } else {
//               // List<Application> apps = data.data;
//               return SafeArea(
//                 child: Scrollbar(
//                   child: ListView.builder(
//                       itemCount: 20,
//                       itemBuilder: (BuildContext bc, int index) {
//                         if(index != 0){
//                           currentAppNumber += 2;
//                         }
//                         return  
//                       }),
//                 ),
//                 //     GridView.builder(
//                 //         physics: BouncingScrollPhysics(),
//                 //         padding: EdgeInsets.symmetric(horizontal: 10),
//                 //         gridDelegate:
//                 //             SliverGridDelegateWithFixedCrossAxisCount(
//                 //                 childAspectRatio: 1.1, crossAxisCount: 2),
//                 //         itemBuilder: (BuildContext context, int position) {
//                 //           Application app = apps[position];
//                 //           return app is ApplicationWithIcon
//                 //               ? tile(MemoryImage(app.icon), app.appName,
//                 //                   app.packageName)
//                 //               : null;
//                 //           // Column(
//                 //           //   children: <Widget>[
//                 //           //     ListTile(
//                 //           //       leading: app is ApplicationWithIcon
//                 //           //           ? CircleAvatar(
//                 //           //               backgroundImage: MemoryImage(app.icon),
//                 //           //               backgroundColor: Colors.white,
//                 //           //             )
//                 //           //           : null,
//                 //           //       onTap: () => DeviceApps.openApp(app.packageName),
//                 //           //       title: Text('${app.appName} (${app.packageName})'),
//                 //           //       subtitle: Text('Version: ${app.versionName}\n'
//                 //           //           'System app: ${app.systemApp}\n'
//                 //           //           'APK file path: ${app.apkFilePath}\n'
//                 //           //           'Data dir: ${app.dataDir}\n'
//                 //           //           'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
//                 //           //           'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'),
//                 //           //     ),
//                 //           //     Divider(
//                 //           //       height: 1.0,
//                 //           //     )
//                 //           //   ],
//                 //           // );
//                 //         },
//                 //         itemCount: apps.length),
//                 //  apps.length),
//               );
//             }
//           }),
//     );
//   }
// }
