import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  late String startDate;
  late String endDate;
  late String startTime;
  late String endTime;
  String? description;
  String? address;
  String? site;

  @override
  String toString() {
    return 'EventDetails{title: $title, description: $description}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'address': address,
      'site': site,
    };
  }
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  final _eventTitleController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _eventStartDateController = TextEditingController();
  final _eventEndDateController = TextEditingController();
  final _eventStartTimeController = TextEditingController();
  final _eventEndTimeController = TextEditingController();
  final _eventAddressController = TextEditingController();
  final _eventSiteController = TextEditingController();

  final dateMask = MaskTextInputFormatter(mask: "##/##/####");
  final timeMask = MaskTextInputFormatter(mask: "##:##");

  EventDetails eventDetails = EventDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child:
          Column(
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
                    TextField(
                      label: 'Data de início',
                      controller: _eventStartDateController,
                      inputFormatters: [dateMask],
                      keyboardType: TextInputType.datetime,
                    ),
                    TextField(
                      label: 'Data de fim',
                      controller: _eventEndDateController,
                      inputFormatters: [dateMask],
                      keyboardType: TextInputType.datetime,
                    ),
                    TextField(
                      label: 'Horário de início',
                      controller: _eventStartTimeController,
                      inputFormatters: [timeMask],
                      keyboardType: TextInputType.datetime,
                    ),
                    TextField(
                      label: 'Horário de fim',
                      controller: _eventEndTimeController,
                      inputFormatters: [timeMask],
                      keyboardType: TextInputType.datetime,
                    ),
                    TextField(
                      label: 'Endereço',
                      controller: _eventAddressController,
                    ),
                    TextField(
                      label: 'Site',
                      controller: _eventSiteController,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          eventDetails.title = _eventTitleController.text;
                          eventDetails.description =
                              _eventDescriptionController.text;
                          eventDetails.startDate = _eventStartDateController.text;
                          eventDetails.endDate = _eventEndDateController.text;
                          eventDetails.startTime = _eventStartTimeController.text;
                          eventDetails.endTime = _eventEndTimeController.text;
                          eventDetails.address = _eventAddressController.text;
                          eventDetails.site = _eventSiteController.text;

                          var url =
                              Uri.https('5ed9-45-174-146-51.sa.ngrok.io', '/');
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
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextField({super.key, required this.label, required this.controller, this.inputFormatters, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
