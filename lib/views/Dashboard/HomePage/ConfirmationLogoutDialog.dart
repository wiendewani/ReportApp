
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:reportapp/views/Login/LoginPage.dart';
import 'package:reportapp/views/SplashScreen/SplashScreenPage.dart';import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationLogoutDialog extends StatelessWidget {
  final BuildContext homePageCtx, sheetDialogCtx;

  ConfirmationLogoutDialog(
      {@required this.homePageCtx, @required this.sheetDialogCtx});

  @override
  Widget build(BuildContext context) {
    print('build confirm');
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(SpacingDimens.spacing24),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: PaletteColor.primarybg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirmation Logout',
                style: TypographyStyle.subtitle1.merge(
                  TextStyle(
                    color: PaletteColor.black,
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Are you sure you want to logout now?',
                style: TypographyStyle.paragraph.merge(
                  TextStyle(
                    color: PaletteColor.grey60,
                  ),
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: RaisedButton(
                      color: PaletteColor.primarybg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(color: PaletteColor.primary),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TypographyStyle.button2.merge(
                          TextStyle(
                            color: PaletteColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: RaisedButton(
                      color: PaletteColor.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(sheetDialogCtx);
                        logOut(homePageCtx);
                      },
                      child: Text(
                        'Yes',
                        style: TypographyStyle.button2.merge(
                          TextStyle(
                            color: PaletteColor.primarybg,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void logOut(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    var userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.user = null;
    userProvider.userDetail = null;
    userProvider.token = null;

    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => SplashScreenPage(),
      ),

      // this function should return true when we're done removing routes
      // but because we want to remove all other screens, we make it
      // always return false
          (Route route) => false,
    );
  }
}
