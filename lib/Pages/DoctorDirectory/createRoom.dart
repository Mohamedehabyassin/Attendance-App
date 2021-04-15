import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_grad_project/Authn/LogIn.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/Instructor.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/QR_Generator.dart';

import 'Course.dart';
class CreateRoom extends StatefulWidget {
   final Instructor instObject;
  CreateRoom(this.instObject);
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {

  var now;
  var myState;
  var time;
  var courseId;
  var roomId=1;
  int randomRoomId;
  String path;
  Random random = new Random();
  TextEditingController instructorNameC = TextEditingController();
  String dropDownSubjectValue = '';
  String dropDownRoomTypeValue='Lecture';
  String dropDownYear='1';
  List<Course> subjectList = [];
  List<String> subjectValueList=[];
  List<String> yearList=["1","2","3","4"];
  List<String> roomTypeList = ['Lecture','Section','Lab'];
  Future _createRoom() async{
    for(int i=0;i<subjectList.length;i++){
      if(subjectList[i].courseTitle==dropDownSubjectValue)
      {
        setState(() {
          courseId=subjectList[i].courseId;
        });
      }
    }
    var url = 'https://modernacademy2020.000webhostapp.com/createRoom.php';
      myState = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    var time = DateFormat.jm().format(DateTime.now()).toString();
    path = dropDownSubjectValue + myState.toString() + widget.instObject.name
          + random.nextInt(100000).toString();
    switch(dropDownRoomTypeValue){
      case "lecture":
        roomId=1;
        break;
      case "lab":
        roomId=2;
        break;
      default:
        roomId=3;
    }
      var res = await http.post(Uri.encodeFull(url),body: {
        "course_id":courseId,
        "date":myState,
        "path":path,
        "year":dropDownYear,
        "time":time,
        "inst_id":widget.instObject.id
      });
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => QrCodeGenerator(path),
    ));

  }
  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    getSubjects();
  }
  void getSubjects() async{
    print("first test");
    var url ='http://modernacademy2020.000webhostapp.com/getSub.php';
    var res = await http.post(Uri.encodeFull(url),body: {
      "instructorId":widget.instObject.id
    });
    List dataSubject = json.decode(res.body);
    setState(() {
      for(int i=0;i<dataSubject.length;i++){
        subjectList.add(Course(dataSubject[i]['course_id'],
            dataSubject[i]['title']));
        subjectValueList.add(dataSubject[i]['title']);
      }
      dropDownSubjectValue=subjectValueList[0];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Room")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LogIn()),
              )
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body:ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Subject Name",
                          style:TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                        ),),
                        SizedBox(width: 20),
                        DropdownButton<String>(
                          value: dropDownSubjectValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 18,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepOrange,
                          ),
                          onChanged: (String newSubValue) {
                            setState(() {
                              dropDownSubjectValue = newSubValue;
                              print(dropDownSubjectValue);
                            });
                          },
                          items: subjectValueList
                              .map<DropdownMenuItem<String>>((String listValue) {
                            return DropdownMenuItem<String>(
                              value: listValue,
                              child: Text(listValue),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        Text("Room Type",
                          style:TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic
                          ),),
                        SizedBox(width: 38,),
                        DropdownButton<String>(
                          value: dropDownRoomTypeValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 18,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepOrange,
                          ),
                          onChanged: (String newRoomValue) {
                            setState(() {
                              dropDownRoomTypeValue = newRoomValue;
                              print(dropDownRoomTypeValue);
                            });
                          },
                          items: roomTypeList
                              .map<DropdownMenuItem<String>>((String listRoomValue) {
                            return DropdownMenuItem<String>(
                              value: listRoomValue,
                              child: Text(listRoomValue),

                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Year",
                          style:TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic
                          ),),
                        SizedBox(width: 78,),
                        DropdownButton<String>(
                          value: dropDownYear,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 18,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepOrange,
                          ),
                          onChanged: (String newRoomValue) {
                            setState(() {
                              dropDownYear = newRoomValue;
                              print(dropDownYear);
                            });
                          },
                          items: yearList
                              .map<DropdownMenuItem<String>>((String listYear) {
                            return DropdownMenuItem<String>(
                              value: listYear,
                              child: Text(listYear),

                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                height: 230,
                padding: EdgeInsets.all(25),
                 margin: EdgeInsets.only(top: 150,left: 30,right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal
                ),
              ),
              Container(
                width: 180,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 70),
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                    color: Colors.deepOrange[800],
                    child: Text("Create Room", style: TextStyle(color: Colors.white),),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: _createRoom
                ),
              )
            ],
          ),
    );
  }
}
