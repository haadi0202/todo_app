//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_app/pages/TaskView.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/calender.dart';
import 'package:todo_app/test.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //initialRoute: "/testPage",
        routes: {
          "/": (context) => Home(),
          "/calender": (context) => Calender(),
          "/taskView": (context) => Taskview(refresh: () {}),
          "/testPage": (context) => ReorderableListViewExample()
        });
  }
}
