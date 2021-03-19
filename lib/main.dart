import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicon/locator.dart';
import 'package:musicon/page/splash/splash_page.dart';
import 'package:musicon/routers.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final newTextTheme = Theme.of(context).textTheme.apply(
  //       bodyColor: Colors.pink,
  //       displayColor: Colors.pink,
  //     );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Routers.toGenerateRoute,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        canvasColor: Colors.black,
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: SplashPage(),
    );
  }
}
