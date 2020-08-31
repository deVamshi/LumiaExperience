import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';

// Box<InstalledAppModel> installedAppsBox = Hive.box<InstalledAppModel>(BOXNAME);
// Box<InstalledAppModel> favoriteAppBox =
//     Hive.box<InstalledAppModel>(FAVORITEBOXNAME);

class InstalledAppsProvider extends ChangeNotifier {
  List<InstalledAppModel> _providerInstalledApps;
  // bool _isEmpty = true;
  List<InstalledAppModel> _appsToShow;
  // List<InstalledAppModel> _favoriteApps = [];
  // int _themeIndex = 1;
  // bool _isBeingEdited = false;

  setSearchedApps(List<InstalledAppModel> apps) {
    _appsToShow = apps;
    notifyListeners();
  }

  List<InstalledAppModel> get getProviderInstalledApps =>
      _providerInstalledApps;
  List<InstalledAppModel> get getAppsToShow => _appsToShow;
  // List<InstalledAppModel> get getFavoriteApps => _favoriteApps;
  // bool get getIsEmpty => _isEmpty;
  // int get themeIndex => _themeIndex;
  // bool get isBeingEdited => _isBeingEdited;

  // setIsBeingEdited() {
  //   _isBeingEdited ? _isBeingEdited = false : _isBeingEdited = true;
  //   notifyListeners();
  // }

  // setFavorite(InstalledAppModel favoriteApp) async {
  //   await favoriteAppBox.add(favoriteApp);
  //   _favoriteApps.add(favoriteApp);
  //   notifyListeners();
  // }

  // removeFavorite(int index) async {
  //   await favoriteAppBox.deleteAt(index);
  //   _favoriteApps.removeAt(index);
  //   notifyListeners();
  // }

  // getFavoriteAppsFromBox() async {
  //   List<InstalledAppModel> favoriteAppsGotFromBox =
  //       favoriteAppBox.values.toList();

  //   if (favoriteAppsGotFromBox.length != 0) {
  //     _favoriteApps = favoriteAppsGotFromBox;
  //     notifyListeners();
  //   } else {
  //     print("favoriteapps got from box is none");
  //   }
  // }

  update() async {
    // if (_appsToShow == null) {
    // if (installedAppsBox.length == 0) {
    // print("got from device apps package");
    await setInstalledAppsInProvider();
    // if (_providerInstalledApps != null) {
    //   _isEmpty = false;
    // }
    notifyListeners();
    // } else {
    //   print("got from hive");
    //   _providerInstalledApps = await providerGetFromBox();
    //   if (_providerInstalledApps != null) {
    //     _isEmpty = false;
    //   }
    //   print("hi dude");
    //   print("after else block");
    //   notifyListeners();
    // }
    // } else {
    //   print(
    //       "appstoshow is not equal to null and need to check for any changes");
    // }
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

  // providerKeepInBox(List<InstalledAppModel> appsToKeep) async {
  //   if (installedAppsBox.length != 0) {
  //     print("in provider keep in box above delete methods");
  //     await deleteAllFromBox();
  //     installedAppsBox.addAll(appsToKeep);
  //   } else {
  //     installedAppsBox.addAll(appsToKeep);
  //   }
  //   print("InstalledAppslengthafterputting is ${installedAppsBox.length}");
  // }

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

  // providerGetFromBox() {
  //   return installedAppsBox.values.toList();
  // }

  // deleteAllFromBox() async {
  //   await installedAppsBox.deleteAll(installedAppsBox.keys.toList());
  // }

  setInstalledAppsInProvider() async {
    List<InstalledAppModel> updatedApps = await createListOfInstalledAppModel();
    print("checkForUpdate");
    _providerInstalledApps = updatedApps;
    notifyListeners();
    // await providerKeepInBox(updatedApps);
    // _providerInstalledApps = await providerGetFromBox();
  }

  // setInstalledAppsInProviderFast() async {
  //   List<InstalledAppModel> updatedApps = await createListOfInstalledAppModel();
  //   print("checkForUpdate");
  //   await providerKeepInBox(updatedApps);
  //   _providerInstalledApps = await providerGetFromBox();
  // }

  checkForUpdateAndUpdate() async {
    List<InstalledAppModel> newList = await createListOfInstalledAppModel();
    if (newList.length != _providerInstalledApps.length) {
      // await providerKeepInBox(newList);
      // _providerInstalledApps = await providerGetFromBox();
      _providerInstalledApps = newList;
      notifyListeners();
      print("appsUpdated");
      return;
    }
    for (int i = 0; i < newList.length; i++) {
      if (newList[i].appName != _providerInstalledApps[i].appName) {
        // await providerKeepInBox(newList);
        // _providerInstalledApps = await providerGetFromBox();
        _providerInstalledApps = newList;
        print('appsupdated');
        notifyListeners();
        return;
      }
    }
    print("app not updated");
  }
}
