import 'package:app_wg/screens/events.dart';
import 'package:app_wg/screens/shoppinglist.dart';
import 'package:app_wg/screens/tasks.dart';
import 'package:flutter/material.dart';

import 'expenses.dart';
import 'mainscreen.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
            icon: Icon(Icons.museum),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Tasks()));
            },
          ),
        ],
      ),
    );
  }
}
