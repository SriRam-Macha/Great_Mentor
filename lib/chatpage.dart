import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Video calling/pages/call.dart';

class ChatPage extends StatefulWidget {
  String _heading;
  String _docid;
  String _class;
  String _subject;
  ChatPage(this._heading, this._docid, this._class,this._subject);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController _textcontroller = TextEditingController();
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //     elevation: 2,
      //     child: Row(
      //       children: [
      //         Container(
      //           height: 20,
      //           child: TextField(
      //               controller: _textcontroller,
      //               style: TextStyle(fontSize: width * 0.05),
      //               keyboardType: TextInputType.text,
      //               maxLines: 1,
      //               textAlign: TextAlign.end,
      //               decoration: new InputDecoration(
      //                 hintStyle: TextStyle(color: Colors.white54),
      //                 contentPadding: EdgeInsets.only(
      //                     left: width * 0.04,
      //                     top: width * 0.041,
      //                     bottom: width * 0.041,
      //                     right: width * 0.04), //15),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(width * 0.04),
      //                   borderSide: BorderSide(
      //                     color: Colors.white,
      //                     width: 2.0,
      //                   ),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(width * 0.04),
      //                   borderSide: BorderSide(
      //                     color: Colors.white,
      //                     width: 2.0,
      //                   ),
      //                 ),
      //               )),
      //         ),
      //       ],
      //     )),
      appBar: AppBar(
        title: Text("Discuss Room"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.video_call),
              onPressed: () async {
                await _handleCameraAndMic();
                // push video page with given channel name
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        channelName: 'abc',
                        role: ClientRole.Broadcaster,
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
