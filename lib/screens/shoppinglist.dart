import 'package:flutter/material.dart';
import 'botNavBar.dart';
import 'addItem.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<String> _items = ['Strawberries','Oil','Salt','Onions'];

  final TextEditingController _textEditingController = TextEditingController();

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
    _textEditingController.clear();
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  void _toggleItemCompletion(String item) {
    setState(() {
      final index = _items.indexOf(item);
      _items[index] = _items[index].startsWith('✓')
          ? _items[index].substring(1)
          : '✓${_items[index]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],

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
              'Shoppinglist',
              style: TextStyle(color: Colors.white),
            ),
          ),

          DeleteButton(
            onPressed: () {
              // Handle button press
            },
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _items[index];
                return Dismissible(
                  key: Key(item),
                  onDismissed: (_) => _removeItem(item),
                  child: CheckboxListTile(
                    value: item.startsWith('✓'),
                    title: Text(
                      item.startsWith('✓') ? item.substring(1) : item,
                    ),
                    onChanged: (_) => _toggleItemCompletion(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }
}

class DeleteButton extends StatelessWidget {

  final VoidCallback onPressed;

  const DeleteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddItem()));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
      child: Text('Add Item')
    );
  }
}