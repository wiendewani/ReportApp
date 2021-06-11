import 'package:flutter/material.dart';
import 'package:reportapp/component/AppBar/AppBarBack.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/views/ListReport/ListReportTile.dart';
import 'package:reportapp/views/ListReport/component/ConfirmationDelete.dart';

class ListReport extends StatefulWidget {
  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBarBack(
      ctx: context,
      title: 'Daftar Report',
    );

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: appBar,
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
//            var item = dataFriday.mosqueFriday.data[index];
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
//              key: Key(item.id.toString()),

            key: Key(""),
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
                judul: "testing",
                penceramah: "wien",
                thumbnail:
                    "https://akcdn.detik.net.id/visual/2018/10/12/118e326e-8b1e-4432-8fe1-63c963367e9d_169.jpeg?w=650",
                waktu: DateTime.now(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},

          ),
    );
  }
}
