import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addquestiondialog.dart';
import 'chatpage.dart';
import 'package:provider/provider.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("English"),
      ),
      body: Container(
        // child: StreamBuilder(
        //   stream: Firestore.instance.collection('Class').document(),
        //   builder: ( , )
        // ),
      ),
    );
  }
}//                   Text(_subjectdata.documents[index].data['Question Heading']),
//               leading: Icon(Icons.question_answer),
//                     MaterialPageRoute(builder: (context) => ChatPage()));
//               },
//             );
// );
