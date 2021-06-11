
import 'package:flutter/material.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext ctx;
  final String title;

  AppBarDefault({@required this.ctx, @required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PaletteColor.primary,
      title: Text(
        title,
        style: TypographyStyle.subtitle0.merge(
          TextStyle(
            color: PaletteColor.primarybg,
          ),
        ),
      ),
    );
  }
}
