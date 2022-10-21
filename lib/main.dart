import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateEventPage(title: 'Cadastrar Evento'),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.title});

  final String title;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class EventDetails {
  late String title;
  late String description;

  @override
  String toString() {
    return 'EventDetails{title: $title, description: $description}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  final _eventTitleController = TextEditingController();
  final _eventDescriptionController = TextEditingController();

  EventDetails eventDetails = EventDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextField(
                    label: 'Título',
                    controller: _eventTitleController,
                  ),
                  TextField(
                    label: 'Descrição',
                    controller: _eventDescriptionController,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        eventDetails.title = _eventTitleController.text;
                        eventDetails.description =
                            _eventDescriptionController.text;

                        var url =
                            Uri.https('6464-45-174-146-51.sa.ngrok.io', '/');
                        var response = await http.post(
                          url,
                          headers: {"content-type": "application/json"},
                          body: jsonEncode(eventDetails),
                        );

                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  // InputDatePickerFormField(
                  //   firstDate: DateTime(DateTime.now().year - 120),
                  //   lastDate: DateTime.now(),
                  //   fieldHintText: 'mm/dd/yyyy',
                  //   fieldLabelText: 'Data de início',
                  // ),
                  // InputDatePickerFormField(
                  //   firstDate: DateTime(DateTime.now().year - 120),
                  //   lastDate: DateTime.now(),
                  //   fieldHintText: 'mm/dd/yyyy',
                  //   fieldLabelText: 'Data de fim',
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
