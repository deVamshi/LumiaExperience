import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_launcher/components/two_bigs.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:minimal_launcher/methods.dart';
import 'package:device_apps/device_apps.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/second_screen_components.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
// import 'package:minimal_launcher/values.dart';
import 'Models/app_model.dart';
import 'second_screen_components.dart';
import 'widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // List<AppModel> installedApps;
  final PreloadPageController controller =
      PreloadPageController(initialPage: 0);
  InstalledAppsProvider provider;
  // List<Widget> screens = [buildMainApps(), secondScreen()];

  @override
  void initState() {
    super.initState();
    provider = Provider.of<InstalledAppsProvider>(context, listen: false);
    provider.update();
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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () => Future(() => false),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: PreloadPageView(
                    // physics: BouncingScrollPhysics(),
                    controller: controller,
                    children: [buildMainApps(), secondScreen()],
                  ),
                ),
              ),
              buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
