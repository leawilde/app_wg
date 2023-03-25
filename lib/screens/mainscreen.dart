import 'package:flutter/material.dart';
import 'botNavBar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 150),
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Shoppinglist',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Icon(
              Icons.person,
              size: 300.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }
}
