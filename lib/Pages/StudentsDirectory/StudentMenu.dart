import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/StudentsDirectory/Student.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {

  final Student _student;
  Menu(this._student);
  @override
  Widget build(BuildContext context) {
    return Center(child:Text("Hello ${_student.name}"));
  }
}
