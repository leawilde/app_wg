import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'botNavBar.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InputFieldsScreen(),
      bottomNavigationBar: BotNavBar(),
    );
  }
}

class InputFieldsScreen extends StatefulWidget {
  @override
  _InputFieldsScreenState createState() => _InputFieldsScreenState();
}

class _InputFieldsScreenState extends State<InputFieldsScreen> {
  late DateTime _selectedDate = DateTime.now();
  String _inputText = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitData() {
    if (_inputText.isEmpty) {
      return;
    } else {
      String date = _selectedDate.year.toString() + '-' + _selectedDate.month.toString() + '-' + _selectedDate.day.toString();
      addEvent(_inputText,date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text('Event hinzufügen', style: TextStyle(color: Colors.white),)
          ),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Text('${_selectedDate.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() {
                _inputText = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Event Beschreibung',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onPressed: (_inputText.isNotEmpty) ? _submitData : null,
            child: Text('Hinzufügen'),
          ),
        ],
      ),
    );
  }

  Future<void> addEvent(String name, String date) async {
    final response = await http.post(
      Uri.parse('https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/events/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'date': date,
      }),
    );

    if (response.statusCode == 201) {
      print('Entry added successfully');
    } else {
      throw Exception('Failed to add entry');
    }
  }


}