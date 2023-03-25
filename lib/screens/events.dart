import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../event.dart';
import 'addEvent.dart';
import 'botNavBar.dart';

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
            child: ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEvent()));
            }, child: Text('Add Event'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
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
                            ElevatedButton(onPressed: () {
                              events.removeAt(index);

                            }, child: Text('remove'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
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
        bottomNavigationBar: BotNavBar()
    );
  }

}