import 'package:flutter/material.dart';
import 'package:app_wg/screens/shoppinglist.dart';
import 'package:app_wg/screens/expenses.dart';
import 'package:app_wg/screens/tasks.dart';

import 'events.dart';


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



      // Informationen einfügen
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Events()));
              },
            ),
            IconButton(
              icon: Icon(Icons.cleaning_services),
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
