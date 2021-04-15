import 'package:flutter/material.dart';
import 'package:my_grad_project/Pages/AdminDirectory/StudentData.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: StudentData(),
    );
  }
}
