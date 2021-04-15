import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/DoctorMenu.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/Instructor.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/createRoom.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/instRooms.dart';


class DoctorPage extends StatefulWidget {

  final Instructor instObject;
  DoctorPage(this.instObject);
    @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  int _currentIndex=1;
  void onTapBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }

  Widget navigate(int no){
    switch(no){
      case 0:
        return CreateRoom(widget.instObject);
      case 1:
        return DoctorMenu(widget.instObject);
      case 2:
        return InstRooms(widget.instObject);
      default:
        return null;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple[900],
        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.teal[900],
        height: 50,
        index: _currentIndex,
        animationCurve: Curves.easeIn,
        items: <Widget>[
          Icon(Icons.create, size: 30),
          Icon(Icons.menu, size: 30),
          Icon(Icons.class_, size: 30),
        ],
        onTap: onTapBar,
      ),
      body: navigate(_currentIndex),
    );
  }
}
//   List<Widget> _children=[
//    CreateRoom(),
//    QrCodeGenerator(),
//    DoctorMenu(),
//    LogIn()
//  ];