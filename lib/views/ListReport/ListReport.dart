import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Animation/RightToLeftTransition.dart';

import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';

import 'package:reportapp/views/DetailReport/DetailReportPage.dart';
import 'package:reportapp/views/ListReport/ListReportTile.dart';
import 'package:reportapp/views/NewReport/NewReportPage.dart';

class ListReport extends StatefulWidget {
  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  @override
  void initState() {
    Provider.of<ReportProvider>(context, listen: false).getReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReportProvider>(
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
      ),
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
