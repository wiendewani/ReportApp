
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class ProfileUserPage extends StatefulWidget {
  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  bool isPhotoNull;

  @override
  void initState() {
//    var userProvider = Provider.of<UsersProvider>(context, listen: false);
//    isPhotoNull = userProvider.photo.endsWith("storage/images/users/");
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

//  navigateTo(BuildContext context, target) {
//    Navigator.push(
//      context,
//      rightToLeftTransition(target),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profle Page',
          style: TypographyStyle.subtitle0.merge(
            TextStyle(
              color: PaletteColor.primarybg,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingDimens.spacing24,
          vertical: SpacingDimens.spacing24,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
//              Center(
//                child: isPhotoNull
//                    ? Consumer<UsersProvider>(
//                  builder: (context, dataUser, _) {
//                    return CircleAvatar(
//                      backgroundColor: PaletteColor.grey40,
//                      radius: SpacingDimens.spacing32,
//                      child: Text(
//                        dataUser.user.data.nama[0].capitalize(),
//                        style: TypographyStyle.title.merge(
//                          TextStyle(
//                            fontSize: SpacingDimens.spacing32,
//                          ),
//                        ),
//                      ),
//                    );
//                  },
//                )
//                    : Consumer<UsersProvider>(
//                  builder: (context, dataUser, _) {
//                    return CachedNetworkImage(
//                      imageUrl: dataUser.photo,
//                      placeholder: (context, url) => indicatorLoad(),
//                      imageBuilder: (context, images) {
//                        return CircleAvatar(
//                          radius: SpacingDimens.spacing64,
//                          backgroundImage: images,
//                          backgroundColor: Colors.transparent,
//                        );
//                      },
//                    );
//                  },
//                ),
//              ),
              SizedBox(
                height: SpacingDimens.spacing64,
              ),
              Divider(
                color: PaletteColor.grey60,
                height: 1,
              ),
//              Consumer<UsersProvider>(
//                builder: (context, dataUsers, _) {
//                  return _biodataField(
//                    "Nama",
//                    dataUsers.user.data.nama == null
//                        ? "-"
//                        : dataUsers.user.data.nama.capitalize(),
//                  );
//                },
//              ),
//              Consumer<UsersProvider>(
//                builder: (context, dataUsers, _) {
//                  return _biodataField(
//                    "Email",
//                    dataUsers.user.data.userCredentials.email == null
//                        ? "-"
//                        : dataUsers.user.data.userCredentials.email
//                        .capitalize(),
//                  );
//                },
//              ),

            ],
          ),
        ),
      ),
    );
  }
}
