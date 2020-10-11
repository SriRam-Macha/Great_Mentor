import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'package:provider/provider.dart';
import 'sign_in.dart';
import 'wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ]);
    return StreamProvider<FirebaseUser>.value(
      value: Auth().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF6D17CB),
        ),
        color: Color(0xFF6D17CB),
        title: 'Flutter Login',
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
