import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graet_mentor/database.dart';
import '../Widgets/addquestiondialog.dart';

import 'package:provider/provider.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'chatscreen.dart';

class SubjectPage extends StatefulWidget {
  String _class;
  String _subject;
  SubjectPage(this._class, this._subject);
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<DocumentSnapshot> _questions = [];
  int _perpage = 15;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;
  bool _loadingProducts = true;
  String _load = "ok";

  _getquestions() async {
    Query q = FirebaseFirestore.instance
        .collection('Class')
        .doc(widget._class)
        .collection(widget._subject)
        // .orderBy("Heading")
        .limit(_perpage);
    setState(() {
      _loadingProducts = true;
    });
    QuerySnapshot querySnapshot = await q.get();
    _questions = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(() {
      _loadingProducts = false;
    });
  }

  _getMoreQuestions() async {
    if (_moreProductsAvailable == false) {
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    print('hello');
    Query q = FirebaseFirestore.instance
        .collection('Class')
        .doc('Class 5')
        .collection('English')
        // .orderBy("Heading")
        .startAfter([_lastDocument.data()['Heading']]).limit(_perpage);
    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < _perpage) {
      _moreProductsAvailable = false;
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    _questions.addAll(querySnapshot.docs);

    setState(() {
      _load = "notok";
    });
    _gettingMoreProducts = false;
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    setState(() {
      _load = "notok";
    });
  }

  @override
  void initState() {
    super.initState();
    _getquestions();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      print(maxScroll);
      print(currentScroll);
      print(delta);
      if (maxScroll - currentScroll < delta) {
        _getMoreQuestions();
      }
    });
  }

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
        title: Text(widget._subject),
      ),
      body:
          // RefreshIndicator(
          //   onRefresh: () {
          //     setState(() {
          //       _loadingProducts = false;
          //     });
          //     return null;
          //   },
          //   child: ListView.builder(
          //       controller: _scrollController,
          //       itemCount: _questions.length,
          //       itemBuilder: (ctx, index) {
          //         return ListTile(
          //           title: Text(_questions[index].data()["Heading"]),
          //         );
          //       }),
          // ));

          SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: PaginateFirestore(
            emptyDisplay: Center(child: Text("No questions found")),
            itemBuilder: (index, context, snapshots) => ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text(snapshots.data()['Heading']),
                  subtitle: Text(snapshots.data()['Status']),
                  trailing: Text(_load),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                snapshots.data()['Heading'],
                                snapshots.id,
                                widget._class,
                                widget._subject)));
                  },
                ),
            query: FirebaseFirestore.instance
                .collection('Class')
                .doc(widget._class)
                .collection(widget._subject)
                .orderBy('Time'),
            itemBuilderType: PaginateBuilderType.listView),
      ),
    );
  }
} //                   Text(_subjectdata.documents[index].data['Question Heading']),
//               leading: Icon(Icons.question_answer),
//                     MaterialPageRoute(builder: (context) => ChatPage()));
//               },
//             );
// );
