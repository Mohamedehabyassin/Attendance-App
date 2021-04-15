import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_grad_project/Authn/LogIn.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/QrScanner.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Student.dart';
import 'Room.dart';

class GetRooms extends StatefulWidget {

  final Student myStudentObject;
  GetRooms(this.myStudentObject);
  @override
  _GetRoomsState createState() => _GetRoomsState();
}

class _GetRoomsState extends State<GetRooms> {
  
  var now;
  var myState;
  List<Room> myRooms=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRooms();
  }
  void getRooms() async {
    var url='https://modernacademy2020.000webhostapp.com/getRooms.php';
    myState = DateFormat("dd-MM-yyyy").format(DateTime.now());
    var rest = await http.post(Uri.encodeFull(url),body: {
      "date":myState,
    });
    List dataRooms = json.decode(rest.body);
    setState(() {
      for(int i=0;i<dataRooms.length;i++){
        myRooms.add(Room(dataRooms[i]['attendance_id'],
          dataRooms[i]['title'],dataRooms[i]['room_id'],
            dataRooms[i]['dep_name'],dataRooms[i]['date'],
            dataRooms[i]['path'],dataRooms[i]['year'],
            dataRooms[i]['slot_number'],dataRooms[i]['time']));
      }});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => LogIn()),
          )
          )
        ],
        automaticallyImplyLeading: false,
        title: Center(child: Text('Rooms')),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: myRooms.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = myRooms[index];
          return Container(
            margin: EdgeInsets.all(15.0),

            child: RaisedButton(
              color: Colors.deepPurple[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white)
              ),
              child:ListTile(
                title: Text(item.department),
                subtitle: Text(item.date),
                contentPadding: EdgeInsets.all(10.0),
                trailing: Text(item.time),
                leading: Text(item.courseId),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => QrScanner(widget.myStudentObject,myRooms[index]),
                ));              },
            ),
          ) ;
        },
      )
    );
  }
}
/*
 */