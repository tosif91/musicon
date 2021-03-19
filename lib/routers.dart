import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicon/page/bookmark/bookmark_page.dart';
import 'package:musicon/page/home/home_page.dart';
import 'package:musicon/page/trackinfo/trackinfo_page.dart';
import 'package:musicon/utils/routes.dart';

class Routers {
  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case bookmark:
        return MaterialPageRoute(builder: (context) => BookMarkPage());
      case trackInfo:
        return MaterialPageRoute(
            builder: (context) => TrackInfoPage(data: settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('Invalid Route'),
                ));
    } //switch
  }
}
