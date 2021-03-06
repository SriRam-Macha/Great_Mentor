import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:great_mentor/homepage.dart';
import 'package:provider/provider.dart';
import 'loginpage.dart';
import 'homepage.dart';
import 'subjectpage.dart';
import 'profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user);
    if (user == null) {
      print("Navin");
      return LoginPage();
    } else {
      return StreamProvider.value(value: Firestore.instance.collection('users').document(user.uid).snapshots(), child: Homepage());
    }
  }
}
