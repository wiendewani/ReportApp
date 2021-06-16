import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/provider/AuthProvider.dart';
import 'package:reportapp/provider/ReportDetailProvider.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/views/Dashboard/DashboardPage.dart';
import 'package:reportapp/views/SplashScreen/SplashScreenPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UsersProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ReportProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ReportDetailProvider(),
      ),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreenPage(),
      ),
    ),);
  }
}
