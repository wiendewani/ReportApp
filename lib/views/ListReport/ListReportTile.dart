
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class ListReportTile extends StatelessWidget {

  String judul, alamat;
  DateTime waktu;
  final DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy', "id_ID");

  ListReportTile(
      {this.judul,
      this.alamat,
      this.waktu,
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
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/icon.png",
              height: 87,
              width: 87,
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: SpacingDimens.spacing24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SpacingDimens.spacing8,
                  ),
                  Text(
                    "$judul",
                    style: TypographyStyle.paragraph.merge(TextStyle(fontWeight: FontWeight.bold)),
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
