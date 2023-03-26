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

          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Deine WG App ',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'picture/Logo_App.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }
}
