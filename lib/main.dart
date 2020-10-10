import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF9D976),
      ),
      color: Color(0xFFF9D976),
      title: 'Flutter Login',
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
