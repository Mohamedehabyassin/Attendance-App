import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/Instructor.dart';
class DoctorClassAttend extends StatefulWidget {
final Instructor _instructor;
  DoctorClassAttend(this._instructor);
  @override
  _DoctorClassAttendState createState() => _DoctorClassAttendState();
}

class _DoctorClassAttendState extends State<DoctorClassAttend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello ${widget._instructor.name}"),
      ),
    );
  }
}
