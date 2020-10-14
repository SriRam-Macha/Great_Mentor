import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/loginpage.dart';
import 'Screens/homepage.dart';
import 'Screens/subjectpage.dart';
import 'Screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  DocumentSnapshot data;
  _getdata(User user) async {
    data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    setState(() {
      _getdata(user);
    });
    if (user == null) {
      print("Navin");
      return LoginPage();
    } else {
      return StreamProvider<DocumentSnapshot>.value(
          value: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          child: Homepage());
    }
  }
}
