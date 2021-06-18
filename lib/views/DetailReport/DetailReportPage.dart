import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/AppBarBack.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:reportapp/provider/ReportDetailProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class DetailReportPage extends StatelessWidget {
  final String idReport;
  bool isPhotoNull;

  DetailReportPage({this.idReport});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBarBack(
      ctx: context,
      title: 'Detail Report',
    );
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<ReportDetailProvider>(context,listen: false).getReportDetail(idReport)
        ]),
        builder: (context,snapshopt){
          if(snapshopt.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          return Consumer<ReportDetailProvider>(
            builder: (context,dataReportDetail,_){
              var item = dataReportDetail.responeReportDetail.data;
              return ListView(
                children: [
                  item.image.isNotEmpty ?
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: CachedNetworkImage(
                      imageUrl: GlobalConfigUrl.baseUrl +'uploads/' + item.image[0].gambar,),
                  ) :
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Image.asset("assets/images/image-not-found.png"),
                      ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SpacingDimens.spacing24,
                      vertical: SpacingDimens.spacing32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        contentDetails(
                          title: "No.Tiket",
                          desc: item.noTiket,
                        ),
                        contentDetails(
                          title: "Kejadian",
                          desc:
                          item.kejadian,
                        ),
                        contentDetails(
                          title: "Tanggal",
                          desc: item.tanggal.toString(),
                        ),
                        contentDetails(
                          title: "Lokasi Kejadian",
                          desc: item.lokasiKejadian,
                        ),
                        contentDetails(
                          title: "Petugas",
                          desc: item.namaPetugas,
                        ),
                        contentDetails(
                          title: "Pelapor",
                          desc: item.namaPelapor,
                        ),
                        contentDetails(
                          title: "Tindak Lanjut",
                          desc: item.tindakLanjut,
                        ),


                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      )
    );
  }

  Widget contentDetails({@required String title, @required String desc}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TypographyStyle.paragraph.merge(
            TextStyle(
              color: PaletteColor.primary,
            ),
          ),
        ),
        SizedBox(
          height: SpacingDimens.spacing12,
        ),
        Text(
          desc,
          style: TypographyStyle.subtitle2.merge(
            TextStyle(
              color: PaletteColor.grey,
            ),
          ),
        ),
        SizedBox(
          height: SpacingDimens.spacing28,
        ),
      ],
    );
  }
}
