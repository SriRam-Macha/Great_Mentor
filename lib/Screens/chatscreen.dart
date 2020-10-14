import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Video calling/pages/call.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  String _heading;
  String _docid;
  String _class;
  String _subject;

  ChatScreen(this._heading, this._docid, this._class, this._subject);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TrackingScrollController _controller = TrackingScrollController();
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var _time = DateTime.now();
  List<MessageBubble> messageBubbles = [];
  ScrollController _scrollController = ScrollController();

  String messageText;

  @override
  void initState() {
    super.initState();
    getMessages();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      print(maxScroll);
      print(currentScroll);
      print(delta);
      if (maxScroll - currentScroll == 0) {
        getMoreMessages();
      }
    });
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessages() async {
    Query q = _firestore
        .collection('Class')
        .doc(widget._class)
        .collection(widget._subject)
        .doc(widget._docid)
        .collection('Chat')
        .orderBy('timestamp', descending: true)
        .startAfter([_time]).limit(10);
    QuerySnapshot snapshot = await q.get();
    final messages = snapshot.docs;

    for (var message in messages) {
      final messageText = message.data()['text'];
      final messageSender = message.data()['sender'];
      final date = message.data()['timestamp'];

      final currentUser = loggedInUser.email;

      final messageBubble = MessageBubble(
        sender: messageSender,
        text: messageText,
        isMe: currentUser == messageSender,
        time: date,
      );

      messageBubbles.add(messageBubble);
    }
    print(messageBubbles.last.text);
    print(messageBubbles.first.text);
  }

  void getMoreMessages() async {
    messageBubbles.forEach((element) => print(element.text));
    Query q = _firestore
        .collection('Class')
        .doc(widget._class)
        .collection(widget._subject)
        .doc(widget._docid)
        .collection('Chat')
        .orderBy('timestamp', descending: true)
        .startAfter([messageBubbles.last.time]).limit(10);
    QuerySnapshot snapshot = await q.get();
    final messages = snapshot.docs;

    for (var message in messages) {
      final messageText = message.data()['text'];
      final messageSender = message.data()['sender'];
      final date = message.data()['timestamp'];

      final currentUser = loggedInUser.email;

      final messageBubble = MessageBubble(
        sender: messageSender,
        text: messageText,
        isMe: currentUser == messageSender,
        time: date,
      );

      messageBubbles.add(messageBubble);
    }
    print(messageBubbles.last.text);
    print(messageBubbles.last.time);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.video_call),
              onPressed: () async {
                await _handleCameraAndMic();
                // push video page with given channel name
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        channelName: widget._docid,
                        role: ClientRole.Broadcaster,
                      ),
                    ));
              },
            ),
          )
        ],
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('Class')
                  .doc(widget._class)
                  .collection(widget._subject)
                  .doc(widget._docid)
                  .collection('Chat')
                  .orderBy('timestamp')
                  .where('timestamp', isGreaterThan: _time)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final date = message.data()['timestamp'];

                  final currentUser = loggedInUser.email;

                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                    time: date,
                  );

                  messageBubbles.insert(0, messageBubble);

                  print('called');
                }
                return Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messageBubbles.length,
                        reverse: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        itemBuilder: (ctx, index) {
                          return messageBubbles[index];
                        }));
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore
                          .collection('Class')
                          .doc(widget._class)
                          .collection(widget._subject)
                          .doc(widget._docid)
                          .collection('Chat')
                          .add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.time});

  final String sender;
  final String text;
  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Theme.of(context).primaryColor : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
