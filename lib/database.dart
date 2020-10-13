import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference _usercollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _classcollection =
      FirebaseFirestore.instance.collection("Class");

  Future<void> updateStudentData(
      {String name = '', String email = '', String classname = ''}) async {
    return await _usercollection
        .doc(uid)
        .set({'Name': name, 'Class': classname, 'email': email});
  }

  Future<void> getSubjects(String classes) async {
    return _classcollection.doc(classes).snapshots();
  }

  Future<void> updateQuestion(
    String heading,
    String description, {
    String img = '',
    String status = 'Unsolved',
  }) async {
     await _classcollection
        .doc('Class 5')
        .collection('English')
        .doc()
        .set({
      'Heading': heading,
      'Description': description,
      'img': img,
      'Time': FieldValue.serverTimestamp(),
      'Status': status
      
    });
    
    return ;
    
  }

  getquestions() async {
    Query q = _classcollection
        .doc('Class 5')
        .collection('English')
        .orderBy("date")
        .limit(10);
    QuerySnapshot querySnapshot = await q.get();
    return querySnapshot.docs;
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
