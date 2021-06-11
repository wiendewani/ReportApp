
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class ListReportTile extends StatelessWidget {
  String judul, penceramah;
  DateTime waktu;
  String thumbnail;
  final DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy', "id_ID");

  ListReportTile(
      {this.judul,
        this.penceramah,
        this.waktu,
        this.thumbnail,
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
          CachedNetworkImage(
            imageUrl: thumbnail,
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
                    "Jln Tlogomas ",
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
                    "Petugas : $penceramah",
                    style: TypographyStyle.mini,
                  ),
                  SizedBox(
                    height: SpacingDimens.spacing4,
                  ),
                  Text(
                    "Tindak Lanjut : $penceramah",
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
