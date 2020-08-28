import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/main.dart';

Box<InstalledAppModel> installedAppsBox = Hive.box<InstalledAppModel>(BOXNAME);

class InstalledAppsProvider extends ChangeNotifier {
  List<InstalledAppModel> _providerInstalledApps;
  bool _isEmpty = true;
  List<InstalledAppModel> _appsToShow;
  List<InstalledAppModel> _favoriteApps;

  setSearchedApps(List<InstalledAppModel> apps) {
    _appsToShow = apps;
    notifyListeners();
  }

  List<InstalledAppModel> get getProviderInstalledApps =>
      _providerInstalledApps;
  List<InstalledAppModel> get getAppsToShow => _appsToShow;
  List<InstalledAppModel> get getFavoriteApps => _favoriteApps;
  bool get getIsEmpty => _isEmpty;

  checkForRequirementOfUpdate() async {
    List<InstalledAppModel> newModel = await createListOfInstalledAppModel();
  }

  update() async {
    if (_appsToShow == null) {
      if (installedAppsBox.length == 0) {
        print("got from device apps package");
        await setInstalledAppsInProvider();
        if (_providerInstalledApps != null) {
          _isEmpty = false;
        }
        notifyListeners();
      } else {
        print("got from hive");
        _providerInstalledApps = await providerGetFromBox();
        if (_providerInstalledApps != null) {
          _isEmpty = false;
        }
        print("hi dude");
        print("after else block");
        // if(!_isDisposed) notifyListeners();
        notifyListeners();
        // notifyListeners();
      }
    } else {
      print(
          "appstoshow is not equal to null and need to check for any changes");
    }
  }

  getCurrentInstalledApps() async {
    print("in curren installed apps");
    List<Application> appsOrdered = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);
    appsOrdered.sort((a, b) {
      return a.appName.toLowerCase().compareTo(
            b.appName.toLowerCase(),
          );
    });
    print("in curren installed apps below");

    return appsOrdered;
  }

  providerKeepInBox(List<InstalledAppModel> appsToKeep) async {
    // List<InstalledAppModel> appsToKeep = await createListOfInstalledAppModel();

    if (installedAppsBox.length != 0) {
      print("in provider keep in box above delete methods");
      await deleteAllFromBox();
      installedAppsBox.addAll(appsToKeep);
    } else {
      installedAppsBox.addAll(appsToKeep);
    }
    print("InstalledAppslengthafterputting is ${installedAppsBox.length}");
  }

  createListOfInstalledAppModel() async {
    List<Application> currentInstalledApps = await getCurrentInstalledApps();
    print("in createListOfInstalledAppModel ");
    List<InstalledAppModel> result = [];

    for (Application app in currentInstalledApps) {
      InstalledAppModel appModel = InstalledAppModel(
          appName: app.appName,
          packageName: app.packageName,
          appIcon: app is ApplicationWithIcon ? app.icon : Uint8List(0));
      result.add(appModel);
    }
    return result;
  }

  providerGetFromBox() {
    return installedAppsBox.values.toList();
  }

  deleteAllFromBox() async {
    // print("In delete all methods");
    await installedAppsBox.deleteAll(installedAppsBox.keys.toList());
    // print("In delete all methods below ");
  }

  setInstalledAppsInProvider() async {
    List<InstalledAppModel> updatedApps = await createListOfInstalledAppModel();
    print("checkForUpdate");
    await providerKeepInBox(updatedApps);
    _providerInstalledApps = await providerGetFromBox();

    // notifyListeners();
  }
}
