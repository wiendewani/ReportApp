
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/config/globalConfigUrl.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class ListReportTile extends StatelessWidget {
  final String idReport;
  String judul, alamat,petugas,tindaklanjut,pelapor;
  DateTime waktu;
  String thumbnail;
  final DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy', "id_ID");

  ListReportTile(
      {this.judul,
        this.petugas,
        this.pelapor,
        this.alamat,
        this.tindaklanjut,
        this.waktu,
        this.thumbnail,
        this.idReport
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: SpacingDimens.spacing12,
          right: SpacingDimens.spacing24,
          left: SpacingDimens.spacing24),
      padding: EdgeInsets.symmetric(
        horizontal: SpacingDimens.spacing24,
        vertical: SpacingDimens.spacing16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: PaletteColor.primarybg2,
        ),
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: Future.wait([
              Provider.of<ReportProvider>(context,listen: false).getReportDetail(idReport)
            ]),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: indicatorLoad(),
                );
              }
              return Consumer<ReportProvider>(
                builder: (context,dataReportDetail,_){
                  var imageUrl = GlobalConfigUrl.baseUrl+'uploads/'+dataReportDetail.responeReportDetail.data.image[0].gambar;
                  print(imageUrl);
                  return CachedNetworkImage(

                    imageUrl: imageUrl,
                    placeholder: (context, url) => indicatorLoad(),
                    imageBuilder: (context, images) {
                      return Container(
                        width: 87,
                        height: 87,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SpacingDimens.spacing8),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: images,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: SpacingDimens.spacing24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TypographyStyle.subtitle2,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing8,
                  ),
                  Text(
                    "$alamat",
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing4,
                  ),
                  Text(
                    dateFormat.format(waktu),
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing8,
                  ),

                  Text(
                    "Petugas : $petugas",
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing4,
                  ),
                  Text(
                    "Pelapor : $pelapor",
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing4,
                  ),
                  Text(
                    "Tindak Lanjut : $tindaklanjut",
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing4,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
