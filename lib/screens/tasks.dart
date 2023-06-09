import 'dart:convert';
import 'package:http/http.dart' as http;
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
  List<String> _tasksDone = [];
  List<Task> tasksBackend = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _savePoints();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Column(
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
              child: Text('Aufgaben', style: TextStyle(color: Colors.white),)
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TasksDone(tasksDone: _tasksDone)));
          }, child: Text('Erledigte Aufgaben'),
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
                Text('Du hast',
                  style: TextStyle(color: Colors.white,),),
                Text('$_points Punkte', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: tasksBackend.length,
                itemBuilder: (context, index){
                  return taskCard(tasksBackend[index]);
                }
              )
      )],
      ),
      bottomNavigationBar: BotNavBar(),
    );
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

  Future<List<dynamic>> fetchTasks() async {
    final response = await http.get(Uri.parse('https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/tasks/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load items');
    }
  }

    Future<void> loadTasks(List<dynamic> items) async {
      for (var item in items) {
        String name = item['name'];
        int points = item['points'];
        tasksBackend.add(Task(description: name, points: points));
      }

  }

  Future<void> initData() async {
    final items = await fetchTasks();
    loadTasks(items);
    _loadPoints();
    _loadItems();
  }

}