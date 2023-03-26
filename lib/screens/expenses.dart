import 'package:flutter/material.dart';
import 'botNavBar.dart';

class Expense {
  final String name;
  final double amount;
  final List<String> virtualPeople;

  Expense({required this.name, required this.amount, required this.virtualPeople});
}

class Expenses extends StatefulWidget {
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenses = [    Expense(name: 'Groceries', amount: 54.23, virtualPeople: ['Me' , 'Patryk', 'Jane']),
    Expense(name: 'Beer', amount: 35.12, virtualPeople: ['Jane', 'Lea']),
    Expense(name: 'Cleaning Stuff', amount: 14, virtualPeople: ['Lea', 'Patryk']),
  ];

  void _addExpense(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    List<String> _selectedVirtualPeople = [''];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ausgabe hinzufügen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Betrag',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              Text('Beteiligte auswählen:'),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  FilterChip(
                    label: Text('Lea'),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedVirtualPeople.add('Lea');
                        } else {
                          _selectedVirtualPeople.remove('Lea');
                        }
                      });
                    },
                    selected: _selectedVirtualPeople.contains('Lea'),
                  ),
                  FilterChip(
                    label: Text('Patryk'),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedVirtualPeople.add('Patryk');
                        } else {
                          _selectedVirtualPeople.remove('Patryk');
                        }
                      });
                    },
                    selected: _selectedVirtualPeople.contains('Patryk'),
                  ),
                  FilterChip(
                    label: Text('Jane'),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedVirtualPeople.add('Jane');
                        } else {
                          _selectedVirtualPeople.remove('Jane');
                        }
                      });
                    },
                    selected: _selectedVirtualPeople.contains('Jane'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                double amount = double.parse(_amountController.text);
                Expense expense = Expense(name: name, amount: amount, virtualPeople: _selectedVirtualPeople);
                setState(() {
                  expenses.add(expense);
                });
                Navigator.pop(context);
              },
              child: Text('Speichern'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Ausgaben',
                  style: TextStyle(color: Colors.white),
                ),

              ],
            ),
          ),
          SizedBox(height: 20), // Add some spacing between the two widgets
          ElevatedButton(
            onPressed: () => _addExpense(context),
            child: Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                Expense expense = expenses[index];
                double splitAmount = expense.amount / expense.virtualPeople.length;
                return ListTile(
                  title: Text(expense.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('€${expense.amount.toStringAsFixed(2)}'),
                      Text('Pro Person: €${splitAmount.toStringAsFixed(2)}'),
                      Text('Beteiligte: ${expense.virtualPeople.map((virtualPerson) => virtualPerson.toString()).join(', ')}'),
                    ],
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
