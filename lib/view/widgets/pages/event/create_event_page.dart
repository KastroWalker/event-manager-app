import 'dart:convert';

import 'package:event_manager/view/widgets/form/date_form_field.dart';
import 'package:event_manager/view/widgets/form/form_text_field.dart';
import 'package:event_manager/view/widgets/form/time_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
      'userId': 9
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

  EventDetails eventDetails = EventDetails();

  String formatDate(date) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(date); // <-- dd/MM 24H format
    final dateFormated = outputFormat.format(inputDate);
    return dateFormated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                  FormTextField(
                    label: 'T??tulo*',
                    controller: _eventTitleController,
                    required: true,
                  ),
                  FormTextField(
                    label: 'Descri????o',
                    controller: _eventDescriptionController,
                  ),
                  DateFormField(
                    label: 'Data de in??cio*',
                    controller: _eventStartDateController,
                    required: true,
                  ),
                  DateFormField(
                    label: 'Data de fim*',
                    controller: _eventEndDateController,
                    required: true,
                  ),
                  TimeFormField(
                    label: 'Hor??rio de in??cio*',
                    controller: _eventStartTimeController,
                    required: true,
                  ),
                  TimeFormField(
                    label: 'Hor??rio de fim*',
                    controller: _eventEndTimeController,
                    required: true,
                  ),
                  FormTextField(
                    label: 'Endere??o',
                    controller: _eventAddressController,
                  ),
                  FormTextField(
                    label: 'Site',
                    controller: _eventSiteController,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        eventDetails.title = _eventTitleController.text;
                        eventDetails.description =
                            _eventDescriptionController.text;
                        eventDetails.startDate =
                            formatDate(_eventStartDateController.text);
                        eventDetails.endDate =
                            formatDate(_eventEndDateController.text);
                        eventDetails.startTime = _eventStartTimeController.text;
                        eventDetails.endTime = _eventEndTimeController.text;
                        eventDetails.address = _eventAddressController.text;
                        eventDetails.site = _eventSiteController.text;

                        var url = Uri.http('10.0.2.2:8080', '/events');
                        var response = await http.post(
                          url,
                          headers: {"content-type": "application/json"},
                          body: jsonEncode(eventDetails),
                        );

                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                      }
                    },
                    child: const Text('Cadastrar'),
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