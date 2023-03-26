import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../item.dart';
import 'botNavBar.dart';
import 'addItem.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  late Future<List<Item>> _itemsFuture;
  late List<Item> _items;

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchItems();
  }

  void _toggleItemCompletion(int index) {
    setState(() {
      //final index = _items.indexOf(item);
      _items[index].name = _items[index].name.startsWith('✓')
          ? _items[index].name.substring(1)
          : '✓${_items[index].name}';
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
              'Einkaufsliste',
              style: TextStyle(color: Colors.white),
            ),
          ),
          DeleteButton(
            onPressed: () {
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: _itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  _items = snapshot.data!;
                  return ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final itemName = _items[index].name;
                      return Dismissible(
                        key: Key(itemName),
                        onDismissed: (_) {
                          setState(() {
                            deleteItem(_items[index].id);
                            _items.removeAt(index);
                          });
                        },
                        child: CheckboxListTile(
                          value: itemName.startsWith('✓'),
                          title: Text(
                            itemName.startsWith('✓')
                                ? itemName.substring(1)
                                : itemName,
                          ),
                          onChanged: (_) => _toggleItemCompletion(index),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotNavBar(),
    );
  }

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(
        'https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/items/'));

    if (response.statusCode == 200) {
      List<dynamic> eventsJson = jsonDecode(response.body);
      List<Item> items = eventsJson.map((item) {
        return Item(
          id: item['id'],
          amount: item['amount'],
          name: item['name'],
        );
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse(
          'https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/items/$id'),
    );

    if (response.statusCode == 204) {
      print('Entry deleted successfully');
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete entry');
    }
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()));
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
        child: Text('Eintrag hinzufügen'));
  }
}
