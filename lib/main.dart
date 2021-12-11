import 'package:bmi_calculator/modules/bmi/home_scr.dart';
import 'package:bmi_calculator/modules/other/login_scr.dart';
import 'package:bmi_calculator/modules/other/tets_fun.dart';
import 'package:bmi_calculator/layout/todo_home_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: TodoHomeLayout()),
    );
  }
}