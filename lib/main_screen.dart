import 'dart:math';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_launcher/Models/favorite_apps_provider.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/provider/theme_provider.dart';
import 'package:minimal_launcher/provider/values.dart';
import 'package:provider/provider.dart';
import 'Models/installed_app_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Random rnd = Random();

class _MainScreenState extends State<MainScreen> {
  InstalledAppsProvider _installedAppsProvider;
  @override
  void initState() {
    super.initState();
    importantMethod();
  }

  importantMethod() async {
    _installedAppsProvider =
        Provider.of<InstalledAppsProvider>(context, listen: false);
    await Provider.of<FavoriteAppsProvider>(context, listen: false)
        .getFavoriteAppsFromBox();
    await Provider.of<InstalledAppsProvider>(context, listen: false).update();
    // appsToSend = _providerInMainScreen.getProviderInstalledApps;
  }

  Widget tile(InstalledAppModel appModel, int index, bool isBeingEdited) {
    int number = rnd.nextInt(4);
    return Consumer<ThemeProvider>(
      builder: (bc, data, child) {
        return Card(
          color: Values.themes[data.themeIndex][number],
          child: InkWell(
            onLongPress: () {
              // Provider..setIsBeingEdited();
              Provider.of<FavoriteAppsProvider>(context, listen: false)
                  .setIsBeingEdited();
            },
            splashColor: Colors.white,
            onTap: () {
              if (isBeingEdited) {
                Provider.of<FavoriteAppsProvider>(context, listen: false)
                    .setIsBeingEdited();
                return;
              }
              DeviceApps.openApp(appModel.packageName);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                children: [
                  Center(
                    child: fragmentMemoryImageWidget(
                        appModel.appIcon, index.isEven ? 45 : 35),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Text(
                      appModel.appName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  isBeingEdited
                      ? Positioned(
                          top: 5,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<FavoriteAppsProvider>(context,
                                        listen: false)
                                    .removeFavoriteApp(index);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      : Text("")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("mainscreen");
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () => Future(() => false),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (Provider.of<FavoriteAppsProvider>(context, listen: false)
                  .isBeingEdited) {
                Provider.of<FavoriteAppsProvider>(context, listen: false)
                    .setIsBeingEdited();
              }
            },
            onHorizontalDragUpdate: (dragDetails) async {
              if (dragDetails.delta.dx < 0) {
                Navigator.pushNamed(context, "/second");
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Consumer<FavoriteAppsProvider>(
                      builder: (bc, data, child) {
                        List<InstalledAppModel> appsInStaggeredGridView =
                            data.favoriteAppsList;

                        bool isBeingEdited = data.isBeingEdited;
                        return appsInStaggeredGridView.isNotEmpty
                            ? StaggeredGridView.countBuilder(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                crossAxisCount: 4,
                                itemCount: appsInStaggeredGridView?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  InstalledAppModel appModel =
                                      appsInStaggeredGridView[index];
                                  return tile(appModel, index, isBeingEdited);
                                },
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(
                                        index.isEven ? 2 : 1, 1.2),
                                mainAxisSpacing: isBeingEdited ? 10 : 0.0,
                                crossAxisSpacing: isBeingEdited ? 10 : 0.0,
                              )
                            : child;
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "- Pin your favorite apps here",
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "- Long press on any app for more options",
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/second'

                                  // PageTransition(
                                  //   type: PageTransitionType.rightToLeft,
                                  //   child: SecondScreen(
                                  //     providerInSecondScreen:
                                  //         _installedAppsProvider,
                                  //     favoriteAppsProvider:
                                  //         Provider.of<FavoriteAppsProvider>(
                                  //             context,
                                  //             listen: false),
                                  //     themeProvider: Provider.of<ThemeProvider>(
                                  //         context,
                                  //         listen: false),
                                  //   ),
                                  // ),
                                  );
                            },
                            child: Text(
                              "Go to apps",
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                            color: Colors.red[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                buildBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // static Random() {}
}
