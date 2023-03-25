import 'package:flutter/material.dart';
import 'botNavBar.dart';


class TasksDone extends StatelessWidget {
  const TasksDone({Key? key, required this.tasksDone}) : super(key: key);
  final List<String> tasksDone;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.red[200],
      body: Column(
        children: [
          Container(
      margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Text('Tasks Done', style: TextStyle(color: Colors.white),)
        ),
          Expanded(
            child: ListView.builder(
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
          )],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }
}
