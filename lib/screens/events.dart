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

  List<Event> events = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

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
                            Text(events[index].date, style: TextStyle(color: Colors.black),),
                            Text(events[index].description, style: TextStyle(color: Colors.black),),
                            ElevatedButton(onPressed: () {
                              setState(() {
                                deleteEvent(events[index].id);
                                initData();
                              });
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

  Future<List<dynamic>> fetchEvents() async {
    final response = await http.get(Uri.parse('https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/events/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> loadEvents(List<dynamic> items) async {
    for (var item in items) {
      String date = item['date'];
      String name = item['name'];
      int id = item['id'];
      events.add(Event(id: id, date: date, description: name));
    }

  }

  Future<void> initData() async {
    events.clear();
    final items = await fetchEvents();
    loadEvents(items);
  }

  Future<void> deleteEvent(int id) async {
    final response = await http.delete(
      Uri.parse('https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/events/$id'),
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