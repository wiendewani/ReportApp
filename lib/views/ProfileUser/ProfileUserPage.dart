import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/config/globalKeySharedPref.dart';
import 'package:reportapp/provider/UserProvider.dart';

import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserPage extends StatefulWidget {

  final String idUser;

  ProfileUserPage({ this.idUser});

  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  bool isPhotoNull;

  @override
  void initState() {
    super.initState();
  }

  Widget _biodataField(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SpacingDimens.spacing24,
        ),
        Text(
          title,
          style: TypographyStyle.caption.merge(
            TextStyle(
              color: PaletteColor.grey60,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: SpacingDimens.spacing8,
        ),
        Text(
          content,
          style: TypographyStyle.caption.merge(
            TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColor.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: SpacingDimens.spacing12),
          child: Text(
            'Profle Page',
            style: TypographyStyle.subtitle0.merge(
              TextStyle(
                color: PaletteColor.primarybg,
              ),
            ),
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingDimens.spacing24,
          vertical: SpacingDimens.spacing24,
        ),
     child: FutureBuilder(
       future: Future.wait([
         Provider.of<UsersProvider>(context,listen: false).getUserDetail(
           widget.idUser
         )
       ]),
       builder: (context,snapshot){
         if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(
             child: indicatorLoad(),
           );
         }
         else if(snapshot.hasError){
           return Center(
             child: indicatorLoad(),
           );
         }

         return Consumer<UsersProvider>(
           builder: (context,dataUser,_){
             return SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: dataUser != null ? Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Center(
                       child: CircleAvatar(
                         backgroundColor: PaletteColor.grey40,
                         radius: SpacingDimens.spacing32,
                         child: Text(
                           dataUser.userDetail.data.namaPetugas[0].toUpperCase(),
                           style: TypographyStyle.title.merge(
                             TextStyle(
                               fontSize: SpacingDimens.spacing32,
                             ),
                           ),
                         ),
                       ),
                   ),
                   SizedBox(
                     height: SpacingDimens.spacing16,
                   ),
                   Center(child: Text(dataUser.userDetail.data.namaPetugas)),
                   SizedBox(
                     height: SpacingDimens.spacing44,
                   ),
                   Divider(
                     color: PaletteColor.grey60,
                     height: 1,
                   ),
                   _biodataField("Username", dataUser.userDetail.data.username),
                   _biodataField("Nama Instansi", dataUser.userDetail.data.instansi.namaInstansi),
                   _biodataField("Alamat Instansi", dataUser.userDetail.data.instansi.alamat),
                   _biodataField("Kontak Instansi", dataUser.userDetail.data.instansi.kontak)
                 ],
               ):
                   Center(
                     child: Text("Tidak ada internet"),
                   )
             );
           },
         );
       },
     )
      ),
    );
  }
}
