import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reportapp/views/SplashScreen/SplashScreenPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreenPage(),
      ),
    );
  }
}
