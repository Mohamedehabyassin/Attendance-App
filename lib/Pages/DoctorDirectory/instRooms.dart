import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'Attended.dart';
import 'Instructor.dart';
import 'instRooomsModule.dart';

class InstRooms extends StatefulWidget {

  final Instructor inst;
  InstRooms(this.inst);
  @override
  _InstRoomsState createState() => _InstRoomsState();
}

class _InstRoomsState extends State<InstRooms> {

  @override
  void initState() {
    // TODO: implement initState
    getRooms();
    super.initState();
  }
  var myState;
  List<InstRoomsModule> instRoom =[];
  void getRooms() async {
    var url='https://modernacademy2020.000webhostapp.com/instRoom.php';
    myState = DateFormat("dd-MM-yyyy").format(DateTime.now());
    var rest = await http.post(Uri.encodeFull(url),body: {
      "date":myState,
      "inst_id":widget.inst.id
    });
    List dataRooms = json.decode(rest.body);
    setState(() {
      for(int i=0;i<dataRooms.length;i++){
        instRoom.add(InstRoomsModule(dataRooms[i]['attendance_id'],
            dataRooms[i]['title'], dataRooms[i]['date'],dataRooms[i]['time'],
          dataRooms[i]['year'],
            ));
      }});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: ListView.builder(
    // Let the ListView know how many items it needs to build.
    itemCount: instRoom.length,
    // Provide a builder function. This is where the magic happens.
    // Convert each item into a widget based on the type of item it is.
    itemBuilder: (context, index) {
    final item = instRoom[index];
    return Container(
    margin: EdgeInsets.all(15.0),

    child: RaisedButton(
    color: Colors.deepPurple[900],
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(color: Colors.white)
    ),
    child:ListTile(
    title: Text(item.subjectName),
    subtitle: Text(item.time),
    contentPadding: EdgeInsets.all(10.0),
    trailing: Text(item.date),
    leading: Text(item.year),
    ),
    onPressed: (){
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => Attended(widget.inst,item.attendanceId),
    ));              },
    ),
    ) ;
    },
    )
    );
  }
}
