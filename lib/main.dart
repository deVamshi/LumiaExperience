import 'package:flutter/material.dart';
import 'package:minimal_launcher/main_screen.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:provider/provider.dart';

void main() {
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
      home: ChangeNotifierProvider(
        create: (context) => InstalledAppsProvider(),
        child: MainScreen(),
      ),
    );
  }
}
