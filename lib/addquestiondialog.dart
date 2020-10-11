// import 'package:finacash/Helper/Movimentacoes_helper.dart';
// import 'package:finacash/screen/HomePage.dart';
// import 'package:finacash/screen/InicialPage.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class CustomDialog extends StatefulWidget {
  // final Movimentacoes mov;
  // const CustomDialog({Key key, this.mov}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // var formatter = new DateFormat('dd-MM-yyyy');
  bool edit;

  int _groupValueRadio = 1; //intial value of radio button i.e green
  Color _colorContainer = Colors.green[400]; // intial background color
  Color _colorTextButtom = Colors.green; // intial color of text // value
  TextEditingController _questioncontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController _linkcontroller = TextEditingController();
  //description

  // MovimentacoesHelper _movHelper = MovimentacoesHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if(widget.mov != null){
    //   print(widget.mov.toString());

    //   edit = true;
    //   if(widget.mov.tipo == "d"){
    //     _groupValueRadio =2;
    //     _colorContainer = Colors.red[300];
    //     _colorTextButtom = Colors.red[300];
    //     }

    //   _controllerValor.text = widget.mov.valor.toString().replaceAll("-", "");
    //   _controllerDesc.text = widget.mov.descricao;
    // }else{
    //   edit = false;
    // }
    // print(" edit -> $edit");
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         Payment_page(amount: _pricecontroller.text)));

                        // if(_controllerValor.text.isNotEmpty && _controllerDesc.text.isNotEmpty){
                        //   Movimentacoes mov = Movimentacoes();
                        //   String valor;
                        //   if(_controllerValor.text.contains(",")){
                        //      valor = _controllerValor.text.replaceAll( RegExp(","), ".");
                        //     }else{
                        //       valor = _controllerValor.text;
                        //     }

                        //   mov.data = formatter.format(DateTime.now());
                        //   mov.descricao = _controllerDesc.text;

                        //   if(_groupValueRadio == 1){

                        //     mov.valor = double.parse(valor);
                        //     mov.tipo ="r";
                        //     if(widget.mov != null){ mov.id = widget.mov.id;}
                        //     edit == false ? _movHelper.saveMovimentacao(mov) : _movHelper.updateMovimentacao(mov);
                        //   }
                        //   if(_groupValueRadio == 2){
                        //     mov.valor = double.parse("-" + valor);
                        //     mov.tipo ="d";
                        //     if(widget.mov != null){ mov.id = widget.mov.id;}
                        //     edit == false ? _movHelper.saveMovimentacao(mov) : _movHelper.updateMovimentacao(mov);
                        //   }
                        //   Navigator.pop(context);
                        //   //initState();
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
