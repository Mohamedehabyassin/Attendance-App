import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Assigment.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Map.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Student.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/StudentMenu.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/GetRooms.dart';

class StudentPage extends StatefulWidget {
  final Student studentObject;
  StudentPage(this.studentObject);
  @override
  _StudentPageState createState() => _StudentPageState();
}
class _StudentPageState extends State<StudentPage> {
  int _currentIndex = 2;

  void onTapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget navigate(int no) {
    switch (no) {
      case 0:
        return GetRooms(widget.studentObject);
      case 1:
        return Maps();
      case 2:
        return Menu(widget.studentObject);
      case 3:
        return Assigment();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//          title: Center(
//            child: Text("Student Page"),),
//
//      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple[900],
        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.teal[900],
        height: 50,
        index: _currentIndex,
        animationCurve: Curves.easeIn,
        items: <Widget>[
          Icon(Icons.camera_alt, size: 30),
          Icon(Icons.airport_shuttle, size: 30),
          Icon(Icons.menu, size: 30),
          Icon(Icons.assignment, size: 30),
        ],
        onTap: onTapBar,
      ),
      body: navigate(_currentIndex),
    );
  }
}