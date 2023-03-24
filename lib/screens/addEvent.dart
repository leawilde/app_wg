import 'package:flutter/material.dart';

/*class AddEvent extends StatelessWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}*/

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Input Fields Example')),
        body: InputFieldsScreen(),
      ),
    );
  }
}

class InputFieldsScreen extends StatefulWidget {
  @override
  _InputFieldsScreenState createState() => _InputFieldsScreenState();
}

class _InputFieldsScreenState extends State<InputFieldsScreen> {
  late DateTime _selectedDate;
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
    if (_selectedDate == null || _inputText.isEmpty) {
      return;
    }

    // Process the data
    print('Selected date: $_selectedDate');
    print('Text input: $_inputText');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : 'Selected date: ${_selectedDate.toLocal()}'.split(' ')[0],
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
              labelText: 'Text Input',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: (_selectedDate != null && _inputText.isNotEmpty) ? _submitData : null,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}