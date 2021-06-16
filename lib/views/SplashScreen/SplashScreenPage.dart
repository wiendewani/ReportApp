import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/config/globalKeySharedPref.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/views/Dashboard/DashboardPage.dart';
import 'package:reportapp/views/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isHasLogined =
        prefs.getBool(GlobalKeySharedPref.statusLogin) ?? false;
    String idUser = prefs.getString(GlobalKeySharedPref.idUser);
    print(idUser);

    if (isHasLogined) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DasboardPage(
            idUser: idUser,
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }

    print(isHasLogined);
    return isHasLogined;
  }



  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
              height: 130,
            ),
          ),
          indicatorLoad(),
        ],
      ),
    );
  }
}
