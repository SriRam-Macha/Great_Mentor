import 'package:flutter/material.dart';
import '../database.dart';

class CustomDialog extends StatefulWidget {
  // final Movimentacoes mov;
  // const CustomDialog({Key key, this.mov}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // var formatter = new DateFormat('dd-MM-yyyy');
  bool edit;

  TextEditingController _questioncontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController _linkcontroller = TextEditingController();
  //description

  // MovimentacoesHelper _movHelper = MovimentacoesHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.050)),
        title: Text(
          "Add Question",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF6D17CB),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Enter Question Title",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: _questioncontroller,
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
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Problem Description",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: _descriptioncontroller,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType: TextInputType.text,
                        maxLines: 2,
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
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Image link if any",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                        controller: _linkcontroller,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textAlign: TextAlign.left,
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
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        DatabaseService().updateQuestion(
                            _questioncontroller.text,
                            _descriptioncontroller.text,
                            img: _linkcontroller.text);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02,
                            bottom: width * 0.02,
                            left: width * 0.03,
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Color(0xFF6D17CB),
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
