import 'package:app_wg/screens/shoppinglist.dart';
import 'package:app_wg/screens/tasks.dart';
import 'package:flutter/material.dart';

import '../event.dart';
import 'expenses.dart';
import 'mainscreen.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

  List<Event> events = [Event(date: '23.03.2023', description: 'film schauen'),
    Event(date: '23.03.2023', description: 'film schauen'),
    Event(date: '23.03.2023', description: 'film schauen'),
    Event(date: '23.03.2023', description: 'film schauen'),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: [Container(
      margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Text('Events', style: TextStyle(color: Colors.white),)
    ),
          Container(
            child: ElevatedButton(onPressed: (

                ) {  }, child: Text('Add Event'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index){
                  return Center(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Datum', style: TextStyle(color: Colors.black),),
                            Text(events[index].description, style: TextStyle(color: Colors.black),),
                            ElevatedButton(onPressed: () {}, child: Text('remove'), 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ))
                          ],
                        )),
                  );
                }),
          )],
      ),
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
        )
    );
  }
}
