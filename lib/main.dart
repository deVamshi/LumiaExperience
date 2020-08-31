import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minimal_launcher/Models/favorite_apps_provider.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/main_screen.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/provider/theme_provider.dart';
import 'package:minimal_launcher/second_screen.dart';
import 'package:minimal_launcher/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'provider/list_of_apps_provider.dart';

// const String BOXNAME = 'BOXNAME';
const String FAVORITEBOXNAME = 'FAVORITEBOXNAME';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(InstalledAppModelAdapter());
  // await Hive.openBox<InstalledAppModel>(BOXNAME);
  await Hive.openBox<InstalledAppModel>(FAVORITEBOXNAME);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InstalledAppsProvider>(
          create: (context) => InstalledAppsProvider(),
        ),
        ChangeNotifierProvider<FavoriteAppsProvider>(
          create: (context) => FavoriteAppsProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          // print(settings.name);
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => MainScreen());
              break;
            case '/second':
              return PageTransition(
                  child: SecondScreen(), type: PageTransitionType.rightToLeft);
              break;
            case '/third':
              return MaterialPageRoute(builder: (context) => Settings());
              break;
            default:
              return null;
          }
        },
        initialRoute: '/',
        // routes: {
        //   '/': (context) => MainScreen(),
        //   '/second': (context) => SecondScreen(),
        //   '/third': (context) => Settings(),
        // },
        debugShowCheckedModeBanner: false,
        title: 'Lumia Experience',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MultiProvider(providers: [], child: MainScreen()),
      ),
    );
  }
}
