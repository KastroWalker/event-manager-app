import 'package:event_manager/view/widgets/pages/event/create_event_page.dart';
import 'package:event_manager/view/widgets/pages/event/list_event_page.dart';
import 'package:event_manager/view/widgets/pages/user/create_user_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const home = "/";
  static const create_event = "/create_event";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: home,
      routes: {
        home: (context) => const ListEventPage(title: 'Lista de Eventos'),
        create_event: (context) => const CreateEventPage(title: 'Cadastrar Evento'),
      },
    );
  }
}
