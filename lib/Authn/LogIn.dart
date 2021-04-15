import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'package:my_grad_project/Pages/DoctorDirectory/Instructor.dart';
import 'package:my_grad_project/Pages/DoctorPage.dart';
import 'package:my_grad_project/Pages/StudentPage.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Student.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  Student _student;
  Instructor _instructor;
  String animationType = "idle";
  var hef = Colors.white;
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final userFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  void fail(){
    setState(() {
       hef = Colors.red[900];
      animationType='fail';
    });
  }
  void _loginTeacher() async{
    if(userController.text.isEmpty||passwordController.text.isEmpty){
    fail();
    }
    else
      {
//    try {
//    final result = await InternetAddress.lookup('google.com');
//    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//    print('connected');
//    }
//    } on SocketException catch (_) {
//    print('not connected');
//    }
        var url = 'https://modernacademy2020.000webhostapp.com/getteacher.php';
        var response = await http.post(Uri.encodeFull(url),body:{
          "email":userController.text,
          "password":passwordController.text,
        });

        var dataUser = json.decode(response.body);
        if(dataUser.length==0){
          _loginStudent();
        }else {
          _instructor = Instructor(dataUser[0]['inst_id'],dataUser[0]['name'],
              dataUser[0]['password']);
          if (passwordController.text.compareTo(_instructor.password) == 0) {
            setState(() {
              animationType = "success";
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.pushReplacementNamed(context, '/DoctorPage');
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>DoctorPage(_instructor),
                ));
              }
              );
            });
          }
        }
      }
  }
  void _loginStudent() async{
    final responseT = await http.post(
        "https://modernacademy2020.000webhostapp.com/getS.php",
        body: {
          "email":userController.text,
          "password":passwordController.text
        });
    var dataStudent = json.decode(responseT.body);
    if(dataStudent.length==0){
      fail();
    }
    else {
      _student = Student(dataStudent[0]['stud_id'], dataStudent[0]['name'],
          dataStudent[0]['password'],
          dataStudent[0]['year'], dataStudent[0]['section'],
          dataStudent[0]['fac_id']);
      if (passwordController.text.compareTo(_student.password) == 0) {
        setState(() {
          animationType = "success";
          hef=Colors.green;
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.pushReplacementNamed(context, '/DoctorPage');
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StudentPage(_student),
            ));
          });
        });



      }
      else {
        fail();
      }
    }
    }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      animationType = "idle";
      hef=Colors.white;
      passwordController.clear();
      userController.clear();
    });
    userFocusNode.addListener((){
      if(userFocusNode.hasFocus){
        setState(() {
          animationType="test";
        });
      }else{
        setState(() {
          animationType="idle";
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Log in',
            style: TextStyle(
                fontFamily: 'Dancing',
              fontSize: 40,
              letterSpacing: 2
            ),),
        ),
      ),
      body: SafeArea(
        child: ListView(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            //just for vertical spacing
            SizedBox(
            height: 70,
            width: 200,
        ),
            Center(
        child: Container(
        height: 280,
        width: 280,
        child: CircleAvatar(
        child: ClipOval(
        child: new FlareActor(
          "assets/teddy_test.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: animationType,
        ),
        ),
        backgroundColor: Colors.white,
        )
        ),
        ),
            SizedBox(
        height: 30,
        width: 10,
        ),
            Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email,color: hef),
                  border: InputBorder.none,
                  hintText: "E-mail",
                  contentPadding: EdgeInsets.all(10),
                ),
                controller: userController,
                focusNode: userFocusNode,
              ),
             Divider(),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock,color: hef),
                  border: InputBorder.none,
                  hintText: "Password",
                  contentPadding: EdgeInsets.all(10)
                ),
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFocusNode,
              ),
            ],
          ),
          height: 160,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey
          ),
        ),
              Container(
                width: 150,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 70),
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                    color: Colors.pink,
                    child: Text("Submit", style: TextStyle(color: Colors.white),),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: _loginTeacher
                ),
              )
            ],
    ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//      floatingActionButton: FloatingActionButton(
//            child: Icon(Icons.create,
//            size: 30,
//            color: Colors.deepPurple,),
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => SignUpPage()),);
//        },
//        ),
    );
  }
}



