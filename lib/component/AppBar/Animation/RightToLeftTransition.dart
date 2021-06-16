
import 'package:flutter/material.dart';

Route rightToLeftTransition(Widget target) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOutQuart;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}