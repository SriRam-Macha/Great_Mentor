import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference _usercollection =
      Firestore.instance.collection("users");
  final CollectionReference _classcollection =
      Firestore.instance.collection("Class");

  Future<void> updateStudentData(
      {String name = '', String email = '', String classname = ''}) async {
    return await _usercollection
        .document(uid)
        .setData({'Name': name, 'Class': classname, 'email': email});
  }

  Future<void> getSubjects(String classes) async {
    return _classcollection.document(classes).snapshots();
  }
}

//   Future<void> updateStudentData(String name, String classname) async {
//     return await users.document().setData({
//       'Name': name,
//       'Class': classname,
//     });
//   }

//   Future<void> createquestion() async {
//     return await users.document().setData({});

//     Future<void> createmessages() async {
//       return await users.document().setData({});
//     }

//     Future<void> getsubjects() async {
//       QuerySnapshot qn = await classes.getDocuments();
//       return qn.documents;
//     }
//   }
// }
