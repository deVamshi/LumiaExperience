import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/main.dart';

Box<InstalledAppModel> favoriteAppBox =
    Hive.box<InstalledAppModel>(FAVORITEBOXNAME);

class FavoriteAppsProvider extends ChangeNotifier {
  List<InstalledAppModel> _favoriteAppsList = [];
  bool _isBeingEdited = false;

  List<InstalledAppModel> get favoriteAppsList => _favoriteAppsList;
  bool get isBeingEdited => _isBeingEdited;

  void setFavoriteApp(InstalledAppModel appToKeep) async {
    // if (appToKeep == null) return;
    await favoriteAppBox.add(appToKeep);
    _favoriteAppsList.add(appToKeep);
    notifyListeners();
  }

  void removeFavoriteApp(int index) async {
    await favoriteAppBox.deleteAt(index);
    _favoriteAppsList.removeAt(index);
    if (_favoriteAppsList.isEmpty) _isBeingEdited = false;
    notifyListeners();
  }

  getFavoriteAppsFromBox() async {
    List<InstalledAppModel> favoriteAppsGotFromBox =
        favoriteAppBox.values.toList();
    if (favoriteAppsGotFromBox.length != 0) {
      _favoriteAppsList = favoriteAppsGotFromBox;
      // notifyListeners();
    } else {
      print("favoriteapps got from box is none");
    }
  }

  setIsBeingEdited() {
    _isBeingEdited = !_isBeingEdited;
    notifyListeners();
  }
}
