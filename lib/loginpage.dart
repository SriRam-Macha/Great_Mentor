import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(70, 50, 0, 50),
            height: 300,
            width: 300,
            child: Image.asset(
              'assets/mentorship.png',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75),
            child: OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {
                // signInWithGoogle().whenComplete(() {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) {
                //         return RentInscren();
                //         },
                //       ),
                //     );
                //   });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage("assets/google_logo.png"),
                        height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
