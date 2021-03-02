import 'package:flutter/material.dart';
import 'package:todo_list/screens/edit.dart';
import 'package:todo_list/screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: { //this is to set up routing between the pages/screens
        '/':(context) => Home(), //context is a function used to receive the page objects
        '/home':(context) => Home(),
        '/edit': (context) => Edit()
      },
    );
  }
}
