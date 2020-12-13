import 'package:flutter/material.dart';

class MyRouter extends PageRouteBuilder {
  final Widget widget;
  MyRouter(this.widget)
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            });
}
