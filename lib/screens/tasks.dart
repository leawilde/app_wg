import 'package:flutter/material.dart';
import 'package:app_wg/task.dart';
import 'package:app_wg/screens/shoppinglist.dart';
import 'package:app_wg/screens/expenses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_wg/screens/mainscreen.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late int _points;
  List<Task> tasks = [    Task(description: 'Bad putzen', points: 20),    Task(description: 'Küche putzen', points: 20),    Task(description: 'Flur putzen', points: 10),    Task(description: 'Müll rausbringen', points: 5),    Task(description: 'Boden wischen', points: 10),    Task(description: 'WG Einkauf', points: 5),  ];

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[400],
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Tasks',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              updatePoints(10);
            },
            child: Text('Tasks Done'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Congrats you have got',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$_points Points',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          for (final task in tasks) taskCard(task),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[700],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingList()));
              },
            ),
            IconButton(
              icon: Icon(Icons.euro),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Expenses()));
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Events()));
              },
            ),
            IconButton(
              icon: Icon(Icons.museum),
              onPressed: () {
                // Handle button press
              },
            ),
          ],
        ),
      ),
    );


  }

  void updatePoints(int points) {
    setState(() {
      _points += points;
      _savePoints();
    });
  }

  Widget taskCard(Task task) {
    return InkWell(
      onTap: () {
        setState(() {
          _points += task.points;
          _savePoints();
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text('${task.description} - ${task.points}'),
          ),
        ),
      ),
    );
  }

  Future<void> _savePoints() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _points);
  }

  Future<void> _loadPoints() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = prefs.getInt('counter') ?? 0;
    });
  }
}
