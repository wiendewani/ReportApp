import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future _reportFuture;
  @override
  void initState() {
    _reportFuture = Provider.of<ReportProvider>(context, listen: false).getReport();
    super.initState();
  }
  final DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy ', "id_ID");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColor.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: SpacingDimens.spacing12),
          child: Text("Dashboard",
              style: TypographyStyle.subtitle0
                  .merge(TextStyle(color: PaletteColor.primarybg))),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SpacingDimens.spacing24,
                    vertical: SpacingDimens.spacing16),
                child: Image.asset(
                  "assets/images/image2.png",
                ),
              ),

              FutureBuilder(
                future: _reportFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: indicatorLoad(),
                    );
                  }
                  else if(snapshot.connectionState == ConnectionState.none){
                    print("nanana");
                    return Center(
                      child: indicatorLoad(),
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: indicatorLoad(),
                    );
                  }

                  return Consumer<ReportProvider>(
                    builder: (context, dataReport, _) {
                      return dataReport != null ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SpacingDimens.spacing24),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: PaletteColor.yellow, width: 3),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SpacingDimens.spacing12),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Text(
                                    "Terakhir Update Report",
                                    style: TypographyStyle.subtitle1,
                                  ),
                                  color: PaletteColor.yellow,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpacingDimens.spacing16),
                                  child: Text(
                                    dateFormat.format(dataReport.responeReport.data[0].tanggal),
                                    style: TypographyStyle.title
                                        .merge(TextStyle(fontSize: 18.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SpacingDimens.spacing16,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SpacingDimens.spacing24),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: PaletteColor.yellow, width: 3),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SpacingDimens.spacing12),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Text(
                                    "Total Report",
                                    style: TypographyStyle.subtitle1,
                                  ),
                                  color: PaletteColor.yellow,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpacingDimens.spacing16),
                                  child: Text(
                                    dataReport.responeReport.data.length.toString(),
                                    style: TypographyStyle.title
                                        .merge(TextStyle(fontSize: 70.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ): Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: SpacingDimens.spacing16,
              ),
              FutureBuilder(
                future: Future.wait([
                  Provider.of<UsersProvider>(context, listen: false).getUsers()
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return indicatorLoad();
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: indicatorLoad(),
                    );
                  }

                  return Consumer<UsersProvider>(
                    builder: (context, dataUser, _) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SpacingDimens.spacing24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: PaletteColor.yellow, width: 3),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SpacingDimens.spacing12),
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                "Total Petugas",
                                style: TypographyStyle.subtitle1,
                              ),
                              color: PaletteColor.yellow,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: SpacingDimens.spacing16),
                              child: Text(
                                dataUser.user.data.length.toString(),
                                style: TypographyStyle.title
                                    .merge(TextStyle(fontSize: 70.0)),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
