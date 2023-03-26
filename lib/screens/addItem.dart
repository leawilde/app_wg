import 'package:app_wg/screens/botNavBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: InputFieldsScreen(),
        bottomNavigationBar: const BotNavBar(),
      ),
    );
  }
}

class InputFieldsScreen extends StatefulWidget {
  @override
  _InputFieldsScreenState createState() => _InputFieldsScreenState();
}

class _InputFieldsScreenState extends State<InputFieldsScreen> {
  String _text = '';
  late int _amount;

  void _onSubmit() {
    if (_text.isNotEmpty && _amount != null) {
      print('Text input: $_text');
      print('Numeric input: $_amount');
      addItem(_text, _amount);
    } else {
      print('Both fields must be filled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Text('Eintrag hinzufügen', style: TextStyle(color: Colors.white),)
        ),
          TextField(
            decoration: InputDecoration(labelText: 'was fehlt noch?'),
            onChanged: (value) {
              setState(() {
                _text = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Anzahl'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _amount = int.tryParse(value)!;
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onPressed: _onSubmit,
            child: Text('Hinzufügen'),
          ),
        ],
      ),
    );
  }

  Future<void> addItem(String name, int amount) async {
    final response = await http.post(
      Uri.parse('https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/items/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'amount': amount,
      }),
    );

    if (response.statusCode == 201) {
      print('Entry added successfully');
    } else {
      throw Exception('Failed to add entry');
    }
  }

}