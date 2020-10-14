import 'package:flutter/material.dart';
import 'subjectpage.dart';
import 'sign_in.dart';
import 'loginpage.dart';
import '../database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Video calling/pages/index.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Auth _auth = Auth();
  final CollectionReference _classcollection =
      FirebaseFirestore.instance.collection("Class");
  String _class;

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<DocumentSnapshot>(context);
    final _class = userdata.data()['Class'];
    if (userdata == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            title: Text(_class),
            actions: [
              FlatButton.icon(
                  onPressed: _auth.signOutGoogle,
                  icon: Icon(Icons.account_circle),
                  label: Text('Sign out'))
            ],
          ),
          body: Container(
            child: StreamBuilder(
              stream:
                  _classcollection.doc(_class).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: new Text("Loading"));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data['Subjects'].length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(snapshot.data['Subjects'][index]),
                          leading: Icon(Icons.book),
                          onTap: () {
                            // FutureProvider<QuerySnapshot>.value(
                            //   value: _classcollection
                            //       .document('Class 5')
                            //       .collection(snapshot.data['Subjects'][index])
                            //       .getDocuments(),
                            //   child: SubjectPage(),
                            //   builder: (context, child) {
                            //     return SubjectPage();
                            //   },
                            // );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectPage(_class, snapshot.data['Subjects'][index])));
                          },
                        );
                      });
                }
              },
            ),
          ));
    }
  }
}
