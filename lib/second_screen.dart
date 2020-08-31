import 'package:device_apps/device_apps.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:minimal_launcher/Models/favorite_apps_provider.dart';
import 'package:minimal_launcher/Models/installed_app_model.dart';
import 'package:minimal_launcher/provider/list_of_apps_provider.dart';
import 'package:minimal_launcher/widgets.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/action.dart' as android_action;

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _textEditingController;

  ScrollController _scrollController;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    // Provider.of<InstalledAppsProvider>(context, listen: false)
    //     .checkForUpdateAndUpdate();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
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
          Expanded(
            child: TextField(
              onChanged: (value) async {
                InstalledAppsProvider provider =
                    Provider.of<InstalledAppsProvider>(context, listen: false);
                if (value != "") {
                  List<InstalledAppModel> appsToShow = await searchForApps(
                      value, provider.getProviderInstalledApps);
                  provider.setSearchedApps(appsToShow);
                } else {
                  provider.setSearchedApps(provider.getProviderInstalledApps);
                }
              },
              controller: _textEditingController,
              style: GoogleFonts.lato(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for your apps",
                hintStyle: GoogleFonts.lato(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile listTileInsideDialog(String title, IconData icon, int returnValue) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: returnValue == 1 ? Colors.red : Colors.grey[400],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: returnValue == 1 ? Colors.red : Colors.grey[400]),
          ),
        ],
      ),
      onTap: () {
        Navigator.pop(context, returnValue);
      },
    );
  }

  simpleDialog() {
    return SimpleDialog(
      backgroundColor: Colors.grey[850],
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: [
        listTileInsideDialog("Uninstall app", LineAwesomeIcons.trash, 1),
        // listTileInsideDialog("App Info", LineAwesomeIcons.cog, 2),
        listTileInsideDialog("Pin to home", LineAwesomeIcons.thumbtack, 2),
      ],
    );
  }

  uninstallAppFunc(String packageName) {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_DELETE)
      ..setData(Uri.parse("package:$packageName"))
      ..startActivity().catchError((e) => print(e));
  }

  buildListOfApps() {
    return Consumer<InstalledAppsProvider>(
      builder: (bc, data, child) {
        print('consumer ran');
        // data.checkForUpdateAndUpdate();
        List<InstalledAppModel> appsInListView =
            (data.getAppsToShow == null) || _textEditingController.text == ""
                ? data.getProviderInstalledApps
                : data.getAppsToShow;
        return GestureDetector(
          onHorizontalDragUpdate: (dragDetail) {
            if (dragDetail.delta.dx > 0) {
              Navigator.pop(context, PageTransitionType.rightToLeft);
            }
          },
          onPanDown: (dragDetail) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: AnimationLimiter(
            child: FadingEdgeScrollView.fromScrollView(
              shouldDisposeScrollController: true,
              child: ListView.builder(
                  controller: _scrollController,
                  // physics: BouncingScrollPhysics(),
                  itemCount: appsInListView?.length ?? 0,
                  itemBuilder: (BuildContext bc, int index) {
                    InstalledAppModel app = appsInListView[index];
                    // Application app = localApps[index];
                    // index != 0 ?
                    //   need = (localApps[index].appName[0].toLowerCase() !=
                    //       localApps[index - 1].appName[0].toLowerCase())
                    // : null;
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 300),
                      child: SlideAnimation(
                        horizontalOffset: 100.0,
                        child: FadeInAnimation(
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return simpleDialog();
                                  }).then((returnValue) async {
                                if (returnValue != null) {
                                  print(returnValue);
                                  if (returnValue == 1) {
                                    print("deleting started");
                                    await uninstallAppFunc(app.packageName);
                                    Future.delayed(
                                        const Duration(milliseconds: 3000), () {
                                      data.checkForUpdateAndUpdate();
                                    });
                                    print("deleting done");
                                  }
                                  if (returnValue == 2)
                                    Provider.of<FavoriteAppsProvider>(context,
                                            listen: false)
                                        .setFavoriteApp(app);
                                }
                              });

                              // _scaffoldKey.currentState.showSnackBar(SnackBar(
                              //   // backgroundColor: Colors.green[
                              //   elevation: 50,

                              //   content: Text(
                              //       "Pinned to start!"), //,style: GoogleFonts.lato(color: Colors.grey[400]),),
                              // ));
                            },
                            onTap: () async {
                              await DeviceApps.openApp(app.packageName);
                              Future.delayed(Duration(milliseconds: 3000), () {
                                if (_textEditingController.value != null) {
                                  _textEditingController.clear();
                                  data.setSearchedApps(
                                      data.getProviderInstalledApps);
                                }
                              });
                            },
                            leading: fragmentMemoryImageWidget(app.appIcon, 40),
                            title: Text(
                              "${app.appName}",
                              style: GoogleFonts.lato(
                                  color: Colors.grey[300], fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
    // : showCircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    // print('build method');
    return Scaffold(
      // key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: Provider.of<InstalledAppsProvider>(context),
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
                        color: Colors.grey,
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
                    children: [
                      SizedBox(
                        width: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                iconSize: 28,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/third');
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
