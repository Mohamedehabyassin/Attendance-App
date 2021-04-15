import 'package:flutter/material.dart';
import 'package:my_grad_project/Authn/LogIn.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatefulWidget {
  final String path;

  QrCodeGenerator(this.path);

  @override
  _QrCodeGeneratorState createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {

    @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Center(child: Text("Qr Code")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LogIn()),
              )
          )
        ],
        ),
     //   backgroundColor: Colors.black,),
        body:   Center(
          child: Container(
      child: QrImage(
      data: widget.path,
      size: 350,
      padding: EdgeInsets.all(10),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      ),

          ),
        ),
      );
  }
  /*
  ListView(
            children: <Widget>[ Column(
              children: <Widget>[
                 widget.path != null?
              Container(
                  child: QrImage(
                      data: widget.path,
                      size: 300,
                      padding: EdgeInsets.all(10),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
              ):
              Container(),
             ],
            ),
      ]
          ),
   */
//   void _onClicked(){
//    setState(() {
//      now = new DateTime.now();
//                myState = DateFormat("dd-MM-yyyy hh:mm").format(now);
//                path = myState.toString() + _subjectController.toString();
//     _subjectController.text='';
//
//
//    });
//}
}
