import 'package:flutter/material.dart';

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
              child: Text('Add Event', style: TextStyle(color: Colors.white),)
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
              labelText: 'Event Description',
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
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}