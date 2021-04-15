import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:my_grad_project/Authn/LogIn.dart';

class SplashScreen extends StatelessWidget {
  final pages = [
    PageViewModel(
        pageColor: Colors.grey[500],
        bubble: Image.asset('assets/modern/modern_logo.jpg'),
        body: Text("Smart Attendance System , Bus Tracker , Bubble sheet Assigment"),
        title: Text("University System"),
        textStyle: TextStyle(fontSize: 20.0),
        mainImage: Image.asset(
          'assets/modern/modern_logo.jpg',
          alignment: Alignment.center,
          height: 250,
          width: 480,
        ))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogIn(),
                ));
          },
          pageButtonTextStyles:
              TextStyle(color: Colors.deepPurple, fontSize: 18.0),
        ),
      ),
    );
  }
}
