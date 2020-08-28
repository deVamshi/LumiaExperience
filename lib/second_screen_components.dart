import 'package:device_apps/device_apps.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/settings.dart';
import 'package:minimal_launcher/widgets.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textEditingController = TextEditingController();
  InstalledAppsProvider provider;
  ScrollController scrollController = ScrollController();

  searchForApps(String text, List<InstalledAppModel> localApps) async {
    List<InstalledAppModel> searchResult = localApps
        .where((InstalledAppModel item) =>
            item.appName.toLowerCase().contains(text.toLowerCase()))
        .toList();

    return searchResult;
  }

  @override
  void initState() {
    super.initState();
    initialiseProvider();
  }

  initialiseProvider() async {
    provider = InstalledAppsProvider();
    provider.update();
  }

  mySearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[850], borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child:
              Consumer<InstalledAppsProvider>(builder: (bc, data, chidl) {
            List<InstalledAppModel> installedAppsInTextField =
                data.getProviderInstalledApps;
            return TextField(
              onChanged: (value) async {
                // print(value);
                if (value != "") {
                  List<InstalledAppModel> searches =
                      await searchForApps(value, installedAppsInTextField);
                  data.setSearchedApps(searches);
                } else {
                  data.setSearchedApps(installedAppsInTextField);
                }
              },
              controller: textEditingController,
              style: GoogleFonts.lato(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: data.getIsEmpty
                    ? "Loading Apps..."
                    : "Search for your apps",
                hintStyle: GoogleFonts.lato(color: Colors.grey),
              ),
            );
          }))
        ],
      ),
    );
  }

  // Widget secondaryTile(InstalledAppModel app) {
  //   return ListTile(
  //     onTap: () async {
  //       await DeviceApps.openApp(app.packageName);
  //       // Future.delayed(Duration(milliseconds: 1000), () {
  //       //   if (textEditingController.value != null) {
  //       //     textEditingController.clear();
  //       //     data.setSearchedApps(data.getProviderInstalledApps);
  //       //   }
  //       // });
  //       Future.delayed(Duration(milliseconds: 1000), () {
  //         Navigator.pop(context);
  //       });
  //     },
  //     leading: fragmentMemoryImageWidget(app.appIcon,),
  //     title: Text(
  //       "${app.appName}",
  //       style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
  //     ),
  //   );
  // }

  buildListOfApps() {
    return Consumer<InstalledAppsProvider>(
      builder: (bc, data, child) {
        // print('consumer ran');
        List<InstalledAppModel> appsInListView =
            (data.getAppsToShow == null) || textEditingController.text == ""
                ? data.getProviderInstalledApps
                : data.getAppsToShow;
        return GestureDetector(
          onHorizontalDragUpdate: (dragDetail) {
            if (dragDetail.delta.dx > 0) {
              Navigator.pop(context, PageTransitionType.rightToLeft);
            }
          },
          onPanDown: (dragDetail) {
            FocusScopeNode currentFocus = FocusScope.of(bc);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: FadingEdgeScrollView.fromScrollView(
            shouldDisposeScrollController: true,
            child: ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: appsInListView?.length ?? 0,
                itemBuilder: (BuildContext bc, int index) {
                  // Application app = localApps[index];
                  // index != 0 ?
                  //   need = (localApps[index].appName[0].toLowerCase() !=
                  //       localApps[index - 1].appName[0].toLowerCase())
                  // : null;
                  return ListTile(
                    onTap: () async {
                      await DeviceApps.openApp(
                          appsInListView[index].packageName);
                      Future.delayed(Duration(milliseconds: 1000), () {
                        if (textEditingController.value != null) {
                          textEditingController.clear();
                          data.setSearchedApps(data.getProviderInstalledApps);
                        }
                      });
                    },
                    leading: fragmentMemoryImageWidget(
                        appsInListView[index].appIcon, 40),
                    title: Text(
                      "${appsInListView[index].appName}",
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 20),
                    ),
                  );
                }),
          ),
        );
      },
    );
    // : showCircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ChangeNotifierProvider<InstalledAppsProvider>(
          create: (context) => provider,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "apps",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                iconSize: 28,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Settings(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  LineAwesomeIcons.cog,
                                  color: Colors.white,
                                  size: 25,
                                )),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Scrollbar(child: buildListOfApps()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              mySearchBar(),
              // mySearchBar(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// buildSearchBar(BuildContext context) {
//   SearchBarController _searchBarController = SearchBarController();
//   InstalledAppsProvider provider = Provider.of<InstalledAppsProvider>(context);

//   searchForApps(String text, List<AppModel> localApps) async {
//     List<AppModel> searchResult = localApps
//         .where((AppModel item) =>
//             item.appName.toLowerCase().contains(text.toLowerCase()))
//         .toList();
//     for (AppModel app in searchResult) {
//       print(app.appName);
//     }
//     provider.setSearchedApps(searchResult);
//     return searchResult;
//   }

//   return Consumer<InstalledAppsProvider>(
//     builder: (bc, data, child) {
//       bool isEmpty = data.getIsEmpty;
//       List<AppModel> installedApps = data.getProviderInstalledApps;
//       return SearchBar<AppModel>(
//         debounceDuration: Duration(milliseconds: 500),
//         textStyle: GoogleFonts.lato(color: Colors.white),
//         searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
//         listPadding: EdgeInsets.symmetric(horizontal: 15),
//         onSearch: (value) {
//           searchForApps(value, installedApps);
//         },
//         searchBarStyle: SearchBarStyle(
//             backgroundColor: Colors.grey[850],
//             padding: EdgeInsets.symmetric(horizontal: 10)),
//         hintText: isEmpty ? "Loading apps..." : "Search your apps",
//         icon: isEmpty
//             ? showCircularProgressIndicator()
//             : Icon(
//                 Icons.search,
//                 color: Colors.white,
//               ),
//         searchBarController: _searchBarController,
//         cancellationWidget: Text(
//           "Cancel",
//           style: GoogleFonts.lato(
//             color: Colors.white,
//           ),
//         ),
//         loader: Text(
//           "Searching...",
//           style: GoogleFonts.lato(color: Colors.white),
//         ),
//         emptyWidget: Text(
//           "empty",
//           style: GoogleFonts.lato(color: Colors.white),
//         ),
//         onCancelled: () {
//           FocusScopeNode currentFocus = FocusScope.of(bc);
//           if (!currentFocus.hasPrimaryFocus) {
//             currentFocus.unfocus();
//           }
//         },
//         onItemFound: (AppModel app, int index) {
//           print(index);
//           return ListTile(
//             title: Text(
//               app.appName,
//               style: GoogleFonts.lato(color: Colors.white),
//             ),
//             onTap: () {
//               DeviceApps.openApp(app.packageName);
//             },
//           );
//         },
//       );
//     },
//   );
// }
