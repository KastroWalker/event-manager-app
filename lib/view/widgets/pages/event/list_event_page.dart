import 'dart:convert';

import 'package:event_manager/main.dart';
import 'package:event_manager/view/widgets/form/date_form_field.dart';
import 'package:event_manager/view/widgets/form/form_text_field.dart';
import 'package:event_manager/view/widgets/form/time_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ListEventPage extends StatefulWidget {
  const ListEventPage({super.key, required this.title});

  final String title;

  @override
  State<ListEventPage> createState() => _ListEventPageState();
}

class Event {
  late int id;
  late String title;
  late int userId;

  // late String startDate;
  // late String endDate;
  // late String startTime;
  // late String endTime;
  String? description;

  // String? address;
  // String? site;

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      // 'startDate': startDate,
      // 'endDate': endDate,
      // 'startTime': startTime,
      // 'endTime': endTime,
      // 'address': address,
      // 'site': site,
      'userId': 1
    };
  }
}

class _ListEventPageState extends State<ListEventPage> {
  late Future<List<Event>> events;

  Future<List<Event>> fetchEvents() async {
    var url = Uri.http('10.0.2.2:8080', '/events');
    var response = await http.get(
      url,
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      List eventList = responseBody["content"];
      return eventList.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possível carregar os eventos');
    }
  }

  @override
  void initState() {
    super.initState();
    events = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: events,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Text('Erro ao carregar eventos');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Event event = snapshot.data![index];
                    return ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.description!));
                  },
                );
            }
            return const Text('Unknown error');
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, MyApp.create_event).then(
              (created) => {
                if (created == true)
                  setState(() {
                    events = fetchEvents();
                  })
              },
            );
          },
          child: const Text('Cadastrar Evento'),
        ),
      ),
    );
  }
}
