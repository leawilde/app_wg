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
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Events',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddEvent()));
              },
              child: Text('Event hinzufügen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Event>>(
              future: _eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final events = snapshot.data!;
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  events[index].date,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  events[index].description,
                                  style: TextStyle(color: Colors.black),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        deleteEvent(events[index].id);
                                        events.removeAt(index);
                                      });
                                    },
                                    child: Text('löschen'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))))
                              ],
                            )),
                      );
                      ;
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

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(
        'https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/events/'));

    if (response.statusCode == 200) {
      List<dynamic> eventsJson = jsonDecode(response.body);
      List<Event> events = eventsJson.map((event) {
        return Event(
          id: event['id'],
          date: event['date'],
          description: event['name'],
        );
      }).toList();
      return events;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> deleteEvent(int id) async {
    final response = await http.delete(
      Uri.parse(
          'https://medsrv.informatik.hs-fulda.de/wgbackend/api/v1/events/$id'),
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
