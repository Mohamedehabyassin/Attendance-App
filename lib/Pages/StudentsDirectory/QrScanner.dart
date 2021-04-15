import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_grad_project/Authn/LogIn.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Room.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Student.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class QrScanner extends StatefulWidget {
  final Student studentObject;
  final Room roomObject;
  QrScanner(this.studentObject,this.roomObject);
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  String result;
  String studentName;
  String vodo = "";
  var studentId;
  var attendanceId;
  Future _scanQr() async{
    try{
      String qrResult = await BarcodeScanner.scan();
        result=qrResult;
        attend(qrResult);
    }on PlatformException catch(ex){
      if(ex.code == BarcodeScanner.CameraAccessDenied){
        result = 'Camera permission was denied';
      }
      else{
        setState(() {
          result="Unknowns Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed th back button before scan";
      });
    }catch(ex){
      setState(() {
        result="Unknowns Error $ex";
      });
    }
  }
  void attend(String hot) async{

    if(hot==widget.roomObject.path){

      var url='https://modernacademy2020.000webhostapp.com/attendStudent.php';
      var res = await http.post(Uri.encodeFull(url),body: {
        "stud_id":studentId,
        "attendance_id":attendanceId
      });
      setState(()  {
        vodo="you entered";
      });
    }
    else{
      setState(() {
        vodo="Wrong Code";
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    studentName=widget.studentObject.name;
    studentId=widget.studentObject.id;
    attendanceId=widget.roomObject.attendanceId;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Qr Scanner")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LogIn()),
              )
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200,),
            Text("Hello $studentName \nPlease Scan your Code",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),
            ),
            SizedBox(height: 200,),
            Container(
              height: 50,
              width: 300,
              color: Colors.black,
              child: Center(child: Text("$vodo",
                style:TextStyle(fontSize: 24,
                    fontStyle: FontStyle.italic),)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQr,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.blue[800],
    );
  }
}
