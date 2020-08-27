import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:minimal_launcher/Models/app_model.dart';
// import 'package:launcher_assist/launcher_assist.dart';

Future<List<AppModel>> prepareApps() async {
  List<AppModel> appModelList = [];
  List<Application> appsOrdered = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true);
  appsOrdered.sort((a, b) {
    return a.appName.toLowerCase().compareTo(
          b.appName.toLowerCase(),
        );
  });
  for (Application app in appsOrdered) {
    appModelList.add(AppModel(
        appName: app.appName,
        packageName: app.packageName,
        appIcon: app is ApplicationWithIcon ? app.icon : Uint8List(0)));
  }
  // return appsOrdered;
  return appModelList;
}
