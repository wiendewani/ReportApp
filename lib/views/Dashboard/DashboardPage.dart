import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:reportapp/views/Dashboard/HomePage/HomePage.dart';
import 'package:reportapp/views/ListReport/ListReport.dart';
import 'package:reportapp/views/ProfileUser/ProfileUserPage.dart';

class DasboardPage extends StatefulWidget {
  final String idUser;

  DasboardPage({this.idUser});

  @override
  _DasboardPageState createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DasboardPage> {
  String id;
  _DasboardPageState({this.id});

  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    ListReport(),
    ProfileUserPage(),
  ];

  bool _load = false;

  loadOn() => setState(() => _load = true);

  loadOff() => setState(() => _load = false);

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  void showSnackbar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? Container(
            color: Colors.black26,
            width: double.infinity,
            height: double.infinity,
            child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(
                child: indicatorLoad(),
              ),
            ),
          )
        : Container();

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentTab = 0;
                  });
                },
                child: actionIcon(Icons.home, "Home", 0),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = ListReport();
                    currentTab = 1;
                  });
                },
                child: actionIcon(Icons.report, "Report", 1),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = ProfileUserPage(
                      idUser: widget.idUser,
                    );
                    currentTab = 2;
                  });
                },
                child: actionIcon(Icons.person, "Profile", 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionIcon(IconData icon, String title, int tabNow) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 22,
          color:
              currentTab == tabNow ? PaletteColor.primary : PaletteColor.grey60,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: TypographyStyle.mini.merge(TextStyle(
            color: currentTab == tabNow
                ? PaletteColor.primary
                : PaletteColor.grey60,
          )),
        ),
      ],
    );
  }
}
