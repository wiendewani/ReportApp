import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColor.primary,
        title: Text("Dashboard"),
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
              Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: SpacingDimens.spacing24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: PaletteColor.yellow, width: 3),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: FutureBuilder(
                    future: Future.wait([
                      Provider.of<ReportProvider>(context, listen: false)
                          .getReport()
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return indicatorLoad();
                      }
                      return Consumer<ReportProvider>(
                        builder: (context, dataUser, _) {
                          return Column(
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
                                  dataUser.responeReport.data.length.toString(),
                                  style: TypographyStyle.title
                                      .merge(TextStyle(fontSize: 70.0)),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  )),
              SizedBox(height: SpacingDimens.spacing16,),
              FutureBuilder(
                future: Future.wait([
                  Provider.of<UsersProvider>(context, listen: false).getUsers()
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return indicatorLoad();
                  }

                  return Consumer<UsersProvider>(
                    builder: (context, dataUser, _) {
                      return Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: SpacingDimens.spacing24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: PaletteColor.yellow, width: 3),
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
