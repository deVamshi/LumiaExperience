import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:minimal_launcher/Models/app_model.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/widgets.dart';
import 'package:provider/provider.dart';

secondScreen() {
  TextEditingController textEditingController = TextEditingController();
  searchForApps(String text, List<AppModel> localApps) async {
    List<AppModel> searchResult = localApps
        .where((AppModel item) =>
            item.appName.toLowerCase().contains(text.toLowerCase()))
        .toList();
    // for (AppModel app in searchResult) {
    //   print(app.appName);
    // }

    return searchResult;
  }

  mySearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 48,
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
            List<AppModel> installedAppsInTextField =
                data.getProviderInstalledApps;
            return TextField(
              onChanged: (value) async {
                // print(value);
                if (value != "") {
                  List<AppModel> searches =
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
                hintText:
                    data.isEmpty ? "Loading Apps..." : "Search for your apps",
                hintStyle: GoogleFonts.lato(color: Colors.grey),
              ),
            );
          }))
        ],
      ),
    );
  }

  // secondaryTile(AppModel app) {
  //   return ListTile(
  //     onTap: () {
  //       if (textEditingController.value != null) {
  //         textEditingController.clear();
  //         // InstalledAppsProvider provider = Provider.of<InstalledAppsProvider>(context);

  //       }
  //       DeviceApps.openApp(app.packageName);
  //     },
  //     leading: fragmentMemoryImageWidget(app.appIcon),
  //     title: Text(
  //       "${app.appName}",
  //       style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
  //     ),
  //   );
  // }

  buildListOfApps() {
    return Scrollbar(
      child: Consumer<InstalledAppsProvider>(
        builder: (bc, data, child) {
          List<AppModel> appsInListView =
              (data.getAppsToShow == null) || textEditingController.text == ""
                  ? data.getProviderInstalledApps
                  : data.getAppsToShow;
          return GestureDetector(
            onPanDown: (dragDetail) {
              FocusScopeNode currentFocus = FocusScope.of(bc);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: appsInListView?.length ?? 0,
                itemBuilder: (BuildContext bc, int index) {
                  // Application app = localApps[index];
                  // index != 0 ?
                  //   need = (localApps[index].appName[0].toLowerCase() !=
                  //       localApps[index - 1].appName[0].toLowerCase())
                  // : null;
                  return ListTile(
                    onTap: () {
                      if (textEditingController.value != null) {
                        textEditingController.clear();
                        data.setSearchedApps(data.getProviderInstalledApps);
                      }
                      DeviceApps.openApp(appsInListView[index].packageName);
                    },
                    leading: fragmentMemoryImageWidget(
                        appsInListView[index].appIcon),
                    title: Text(
                      "${appsInListView[index].appName}",
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 20),
                    ),
                  );
                }),
          );
        },
      ),
    );
    // : showCircularProgressIndicator();
  }

  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      mySearchBar(),
      Expanded(
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 45,
                child: IconButton(
                    iconSize: 28,
                    onPressed: () {},
                    icon: Icon(
                      LineAwesomeIcons.cog,
                      color: Colors.white,
                    )),
              ),
              Expanded(
                child: SizedBox(
                  child: buildListOfApps(),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
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
