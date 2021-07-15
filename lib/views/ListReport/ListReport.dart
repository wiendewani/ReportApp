import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Animation/RightToLeftTransition.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';

import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

import 'package:reportapp/views/DetailReport/DetailReportPage.dart';
import 'package:reportapp/views/ListReport/ListReportTile.dart';
import 'package:reportapp/views/NewReport/NewReportPage.dart';

class ListReport extends StatefulWidget {
  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  Future _listReport;
  var statuscode;
  @override
  void initState() {
    _listReport = Provider.of<ReportProvider>(context, listen: false).getReport();
    statuscode = Provider.of<ReportProvider>(context, listen: false).responeReport.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColor.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: SpacingDimens.spacing12),
          child: Text("Daftar Report",style: TypographyStyle.subtitle0.merge(TextStyle(color: PaletteColor.primarybg)),),
        ),
      ),
      body: FutureBuilder(
        future: _listReport,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            if(statuscode != 200){
              return Center(
                child: indicatorLoad(),
              );
            }
          }
          else if(snapshot.hasError){
            return Center(
              child: indicatorLoad(),
            );
          }

          return Consumer<ReportProvider>(
            builder: (context, dataReport, _) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: dataReport.responeReport.data.length,
                itemBuilder: (context, index) {
                  var item = dataReport.responeReport.data[index];
                  return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          rightToLeftTransition(
                            DetailReportPage(
                              idReport: item.idPelapor,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: ListReportTile(
                          alamat: item.lokasiKejadian,
                          judul: item.kejadian,
                          waktu: item.tanggal,
                        ),
                      ));
                },
              );
            },
          );
        },

      )
      ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PaletteColor.primary,
        child: Icon(Icons.add, ),
        onPressed: ()
        {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewReportPage()),
        );
        },
      ),
    );
  }
}
