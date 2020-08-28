import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'installed_app_model.g.dart';

@HiveType(typeId: 0)
class InstalledAppModel {
  @HiveField(0)
  final String appName;
  @HiveField(1)
  final String packageName;
  @HiveField(2)
  final Uint8List appIcon;


  InstalledAppModel({this.appName, this.packageName, this.appIcon});
}
