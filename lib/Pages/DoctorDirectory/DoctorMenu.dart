import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/DoctorDirectory/Instructor.dart';

class DoctorMenu extends StatelessWidget {

  final Instructor inst;
  DoctorMenu(this.inst);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Doc ${inst.name}"),
    );
  }
}
