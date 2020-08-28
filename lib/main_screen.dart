import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/second_screen_components.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'Models/installed_app_model.dart';
import 'second_screen_components.dart';
// import 'package:minimal_launcher/values.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'second_screen_components.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets.dart';
import 'components/tile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // List<AppModel> installedApps;
  final PageController controller = PageController(initialPage: 0);
  InstalledAppsProvider _providerInMainScreen =  InstalledAppsProvider();
  int currentScreen = 0;

  // List<Widget> screens = [buildMainApps(), secondScreen()];

  @override
  void initState() {
    super.initState();
    
    _providerInMainScreen.update();
  }

  // secondScreen() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 200,
  //         child: buildSearchBar(context),
  //       ),
  //       Expanded(
  //         child: SizedBox(
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 50,
  //               ),
  //               Expanded(
  //                 child: SizedBox(
  //                   child: buildListOfApps(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // buildListOfApps() {
  //   return GestureDetector(
  //     onPanDown: (dragDetail) {
  //       FocusScopeNode currentFocus = FocusScope.of(context);
  //       if (!currentFocus.hasPrimaryFocus) {
  //         currentFocus.unfocus();
  //       }
  //     },
  //     child: Scrollbar(
  //       child: Consumer<InstalledAppsProvider>(
  //         builder: (bc, data, child) {
  //           List<AppModel> appsInListView = data.getProviderInstalledApps;

  //           return ListView.builder(
  //               physics: BouncingScrollPhysics(),
  //               // padding: listViewPadding,
  //               itemCount: appsInListView?.length ?? 0,
  //               itemBuilder: (BuildContext bc, int index) {
  //                 // Application app = localApps[index];
  //                 // index != 0 ?
  //                 //   need = (localApps[index].appName[0].toLowerCase() !=
  //                 //       localApps[index - 1].appName[0].toLowerCase())
  //                 // : null;
  //                 return secondaryTile(appsInListView[index]);
  //                 // need
  //                 //     ? primaryTile(localApps[index]) :
  //                 // secondaryTile(apps[index]);
  //               });
  //         },
  //       ),
  //     ),
  //   );
  //   // : showCircularProgressIndicator();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () => Future(() => false),
        child: GestureDetector(
          onHorizontalDragUpdate: (dragDetails) {
            if (dragDetails.delta.dx < 0) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: SecondScreen(),
                ),
              );
            }
          },
          child: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: ChangeNotifierProvider<InstalledAppsProvider>(
                  create: (context) => _providerInMainScreen,
                                  child: Container(
                    // height: 100,
                    child: Consumer<InstalledAppsProvider>(
                      builder: (bc, data, _) {
                        List<InstalledAppModel> appsInStaggeredGridView =
                            (data.getAppsToShow == null)
                                ? data.getProviderInstalledApps?.sublist(0, 30)
                                : data.getAppsToShow?.sublist(0, 30);
                        return StaggeredGridView.countBuilder(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          crossAxisCount: 4,
                          itemCount: appsInStaggeredGridView?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            InstalledAppModel appModel =
                                appsInStaggeredGridView[index];
                            return tile(
                                appModel.appIcon,
                                appModel.appName,
                                appModel.packageName,
                                Colors.grey[850],

                              //  index.isEven ? Colors.blue[400] : Colors.blue,
                                index.isEven ? 45 : 35);
                          },
                          staggeredTileBuilder: (int index) =>
                              //  StaggeredTile.extent(2, index.isEven ? 1 : 2),
                              new StaggeredTile.count(index.isEven ? 2 : 1, 1.2),
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                        );
                      },
                    ),
                  ),
                ),
              ),
              buildBottomBar(),
            ],
          )),
        ),
      ),
    );
  }
}
