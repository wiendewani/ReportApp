import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/AppBarBack.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/views/ListReport/ListReportTile.dart';
import 'package:reportapp/views/ListReport/component/ConfirmationDelete.dart';
import 'package:reportapp/views/NewReport/NewReportPage.dart';

class ListReport extends StatefulWidget {
  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var appBar = AppBarBack(
      ctx: context,
      title: 'Daftar Report',
    );

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: appBar,
      body: FutureBuilder(
        future: Future.wait(
            [Provider.of<ReportProvider>(context, listen: false).getReport()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                  return Dismissible(
                    background: Container(
                      color: PaletteColor.red,
                      margin: EdgeInsets.only(
                          top: SpacingDimens.spacing12,
                          right: SpacingDimens.spacing24,
                          left: SpacingDimens.spacing24),
                      padding: EdgeInsets.symmetric(
                        horizontal: SpacingDimens.spacing24,
                        vertical: SpacingDimens.spacing16,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete_forever,
                          size: 36,
                          color: PaletteColor.primarybg,
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    key: Key(item.idPelapor.toString()),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDelete(
                            ctx: context,
                            message: "Yakin ingin menghapus Jadwal?",
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
//                deleteFriday(dataFriday.mosqueFriday.data[index].id);
//                dataFriday.mosqueFriday.data.removeAt(index);
                    },
                    child: GestureDetector(
                      child: ListReportTile(
                        idReport: item.idPelapor,
                        judul: item.kejadian,
                        alamat: item.lokasiKejadian,
                        pelapor: item.namaPelapor,
                        tindaklanjut: item.tindakLanjut,
                        waktu: item.tanggal,
                        petugas: item.namaPetugas,
                        thumbnail:
                            "https://akcdn.detik.net.id/visual/2020/01/01/a0bc224e-f39f-40d6-9851-1222af80eb84_169.jpeg?w=650",
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
