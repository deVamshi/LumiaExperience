import 'package:flutter/material.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/main_screen.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
const String BOXNAME = 'BOXNAME';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(InstalledAppModelAdapter());
  await Hive.openBox<InstalledAppModel>(BOXNAME);
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumia Experience',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
