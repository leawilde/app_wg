import 'package:flutter/material.dart';
import 'package:app_wg/screens/tasks.dart';


class TasksDone extends StatelessWidget {
  const TasksDone({Key? key, required this.tasksDone}) : super(key: key);
  final List<String> tasksDone;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Tasks Done'),
      ),
      body: ListView.builder(
          itemCount: tasksDone.length,
          itemBuilder: (context, index){
            return Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.all(10),
                  child: Text(tasksDone[index],
                    style: const TextStyle(color: Colors.black, fontSize: 26),)),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[700],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingList()));
              },
            ),
            IconButton(
              icon: Icon(Icons.euro),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Expenses()));
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Tasks()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
