import 'package:flutter/material.dart';
import 'data.dart';
import 'database.dart';
import 'homepage.dart';


class ProfilePage extends StatefulWidget {
  final String userid;
  ProfilePage(this.userid);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _class = FocusNode();
  final _email = FocusNode();
  final _form = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  var _editedProfile = Profile(
    email: '',
    name: '',
    classname: '',
  );
  @override
  void _saveForm() {
    _form.currentState.save();
    print(_editedProfile.name);
    print(_editedProfile.classname);
    print(_editedProfile.email);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Homepage()));
    DatabaseService(uid: widget.userid).updateStudentData(
      name: _editedProfile.name,
      classname: _editedProfile.classname,
      email: _editedProfile.email,
    );
    //String filename = userid;
    //uploadPic(filename);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2.0,
        child: SafeArea(
          child: Container(
            child: InkWell(
              onTap: () {
                _saveForm();
                //  Navigator.pop(context);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFF9D976),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(children: <Widget>[
            TextFormField(
              style: TextStyle(),
              decoration: InputDecoration(labelText: 'Name'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_class);
              },
              onSaved: (value) {
                _editedProfile = Profile(
                  classname: _editedProfile.classname,
                  name: value,
                  email: _editedProfile.email,
                );
              },
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Classname'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_email);
                },
                onSaved: (value) {
                  _editedProfile = Profile(
                      classname: value,
                      name: _editedProfile.name,
                      email: _editedProfile.email);
                },
                focusNode: _class),
            TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedProfile = Profile(
                    classname: _editedProfile.classname,
                    name: _editedProfile.name,
                    email: value,
                  );
                },
                focusNode: _email),
          ]),
        ),
      ),
    );
  }
}
