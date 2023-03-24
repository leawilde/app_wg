import 'package:app_wg/screens/tasksDone.dart';
import 'package:flutter/material.dart';
import 'package:app_wg/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'botNavBar.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  int _points = 0;
  List<Task> tasks = [
    Task(description: 'Bad putzen', points: 20),
    Task(description: 'Küche putzen', points: 20),
    Task(description: 'Flur putzen', points: 10),
    Task(description: 'Müll rausbringen', points: 5),
    Task(description: 'Boden wischen', points: 10),
    Task(description: 'WG Einkauf', points: 5),
  ];
  List<String> _tasksDone = [];

  @override
  void initState() {
    _loadPoints();
    _loadItems();
    super.initState();
  }

  @override
  void dispose() {
    //_loadPoints();
    _savePoints();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _loadPoints();

    return Scaffold(
      backgroundColor: Colors.red[200],
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text('Tasks', style: TextStyle(color: Colors.white),)
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TasksDone(tasksDone: _tasksDone)));
          }, child: Text('Tasks Done'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),

            ),),
          Container(
            margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: <Widget>[
                Text('Congrats you have got',
                  style: TextStyle(color: Colors.white,),),
                Text('$_points Points', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          taskCard(tasks[1]),
          taskCard(tasks[2]),
          taskCard(tasks[3]),
          taskCard(tasks[4]),
          taskCard(tasks[5]),
        ],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }

  void updatePoints(int points) {
    setState(() {
      _points += points;
    });
  }

  Widget taskCard(Task task) {
    return InkWell(
      onTap: () {
        setState(() {
          _points += task.points;
          _addItem(task.description);
          _savePoints();
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _points);
  }

  Future<void> _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> saveStringList(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  Future<List<String>> loadStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> _saveItems() async {
    await saveStringList('_tasksDone', _tasksDone);
  }

  Future<void> _loadItems() async {
    List<String> loadedItems = await loadStringList('_tasksDone');
    setState(() {
      _tasksDone = loadedItems;
    });
  }

  void _addItem(String item) {
    setState(() {
      _tasksDone.add(item);
      _saveItems();
    });
  }

}