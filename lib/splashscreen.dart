import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'loginpage.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        photoSize: 100,
        seconds: 5,
        gradientBackground: LinearGradient(
            begin: Alignment.topLeft,
            colors: [new Color(0xFF6D17CB), new Color(0xFF2876F9)]),
        navigateAfterSeconds: LoginPage(),
        loaderColor: Color(0xFF6D17CB),
        image: Image.asset(
          'assets/mentorship.png',
        ),
        title: Text(
          "Great Mentor",
          style: TextStyle(fontSize: 30),
        ));
  }
}
