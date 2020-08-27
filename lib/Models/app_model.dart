import 'dart:typed_data';

class AppModel {
  final String appName;
  final String packageName;
  final Uint8List appIcon;
  AppModel({this.appName, this.packageName, this.appIcon});
}
