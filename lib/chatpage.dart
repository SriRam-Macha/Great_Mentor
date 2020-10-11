import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController _textcontroller = TextEditingController();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Row(
            children: [
              Container(
                height: 20,
                child: TextField(
                    controller: _textcontroller,
                    style: TextStyle(fontSize: width * 0.05),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    decoration: new InputDecoration(
                      hintStyle: TextStyle(color: Colors.white54),
                      contentPadding: EdgeInsets.only(
                          left: width * 0.04,
                          top: width * 0.041,
                          bottom: width * 0.041,
                          right: width * 0.04), //15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.04),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.04),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
            ],
          )),
      appBar: AppBar(
        title: Text("Discuss Room"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.video_call,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
