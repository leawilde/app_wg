import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_wg/screens/shoppinglist.dart';
import 'package:app_wg/screens/tasks.dart';
import 'package:app_wg/screens/mainscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MainScreen("Tasks"),
      home: MainScreen(),
    );
  }
}


