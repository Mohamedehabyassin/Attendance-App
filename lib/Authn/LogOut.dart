import 'package:flutter/material.dart';
import 'package:my_grad_project/Authn/LogIn.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LogIn(),
    );
  }
}
