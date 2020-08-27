import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:minimal_launcher/Models/app_model.dart';

class InstalledAppsProvider extends ChangeNotifier {
  List<AppModel> providerInstalledApps;
  bool isEmpty = true;
  List<AppModel> appsToShow;

  setSearchedApps(List<AppModel> apps) {
    appsToShow = apps;
    notifyListeners();
  }

  List<AppModel> get getProviderInstalledApps => providerInstalledApps;
  List<AppModel> get getAppsToShow => appsToShow;

  bool get getIsEmpty => isEmpty;

  update() async {
    providerInstalledApps = await providerPrepareApps();
    if (providerInstalledApps != null) {
      isEmpty = false;
    }
    notifyListeners();
  }

  Future<List<AppModel>> providerPrepareApps() async {
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
}
