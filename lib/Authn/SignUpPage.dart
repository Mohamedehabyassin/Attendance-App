import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_grad_project/Authn/LogIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

TextEditingController idC = new TextEditingController();
TextEditingController nameC = new TextEditingController();
TextEditingController eMailC = new TextEditingController();
TextEditingController passwordC = new TextEditingController();
TextEditingController mobileNoC = new TextEditingController();
TextEditingController yearC = new TextEditingController();
TextEditingController classNoC = new TextEditingController();

      @override
      Widget build(BuildContext context) {
        return new Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Sign Up Page",
              style: TextStyle(
                fontFamily: 'Dancing',
                fontSize: 30,
                letterSpacing: 2
              ),
            ),
            ),
          ),
          body:new SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),            
              child:ListView(
                padding: EdgeInsets.all(30),
             //crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
              TextField(
                decoration: new InputDecoration(labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
                cursorColor: Colors.green,
                controller: nameC,
              ),SizedBox(height: 15,),
                 TextField(
                decoration: new InputDecoration(labelText: 'id',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: idC,

              ),SizedBox(height: 15,),
                 TextField(
                decoration: new InputDecoration(labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: eMailC,
              ),SizedBox(height: 15,),
                 TextField(
                decoration: new InputDecoration(labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: passwordC,
              ),SizedBox(height: 15,),
                 TextField(
                decoration: new InputDecoration(labelText: 'Year',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: yearC,
              ),SizedBox(height: 15,),
                 TextField(
                decoration: new InputDecoration(labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: mobileNoC,
              ),SizedBox(height: 15,),TextField(
                decoration: new InputDecoration(labelText: 'Class',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )),
                controller: classNoC,
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
                  onPressed: () {
                    setState(() {
                      _addData();
                      idC.clear();
                      classNoC.clear();
                      nameC.clear();
                      eMailC.clear();
                      passwordC.clear();
                      yearC.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),);
                    });
                  }
              ),
            )],
          ),
          ),
          ),
        );
      }
void _addData() async{
var url = 'https://airiest-halyards.000webhostapp.com/addData.php';
var res = await http.post(Uri.encodeFull(url),body:{
  "id": idC.text,
  "name": nameC.text,
  "mail":eMailC.text,
  "password":passwordC.text,
  "year":yearC.text,
  "mobile_no":mobileNoC.text,
  "class":classNoC.text,
});
var resBody =json.decode(res.body);
print(resBody);
}
}