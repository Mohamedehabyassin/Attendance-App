import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_grad_project/Pages/DoctorDirectory/studentModule.dart';
import 'dart:convert';

import 'Instructor.dart';

// ignore: must_be_immutable
class Attended extends StatefulWidget {

  final Instructor inst;
  // ignore: non_constant_identifier_names
  var attendance_id;
  Attended(this.inst,this.attendance_id);

  @override
  _AttendedState createState() => _AttendedState();
}

class _AttendedState extends State<Attended> {


  List<StudentModule> attendedList=[];

  @override
  void initState() {

    getAttended();// TODO: implement initState
    super.initState();
  }
  void getAttended() async {
    var url='https://modernacademy2020.000webhostapp.com/viewAttend.php';

    print(widget.attendance_id);
    var rest = await http.post(Uri.encodeFull(url),body: {
      "attendance_id":widget.attendance_id,
    });
    List dataRooms = json.decode(rest.body);
    setState(() {
      for(int i=0;i<dataRooms.length;i++){
        attendedList.add(StudentModule(dataRooms[i]['stud_id'],
            dataRooms[i]['name'],dataRooms[i]['year'],dataRooms[i]['section']
            ));
        print(dataRooms[i]['stud_id']);
      }});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("${attendedList.length}")),
      ),
        body: ListView.builder(
    itemCount: attendedList.length,
          itemBuilder: (context, index) {
      final item = attendedList[index];
      return Container(
        margin: EdgeInsets.all(15.0),

        child: RaisedButton(
          onPressed: (){},
          color: Colors.deepPurple[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white)
          ),
          child:ListTile(
            title: Text(item.name),
            subtitle: Text("Section : "+item.section),
            contentPadding: EdgeInsets.all(10.0),
            trailing: Text("Year : "+item.year),
            leading: Text("ID : "+item.id),
          ),
        ),
      ) ;
    },
    )
    );
  }
}
