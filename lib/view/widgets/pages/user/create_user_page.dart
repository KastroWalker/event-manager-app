import 'dart:convert';

import 'package:event_manager/view/widgets/form/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key, required this.title});

  final String title;

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class UserDetails {
  late String name;
  late String email;
  late String password;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final userDetails = UserDetails();

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
                    label: 'Nome*',
                    controller: _userNameController,
                    required: true,
                  ),
                  FormTextField(
                    label: 'Email*',
                    controller: _userEmailController,
                    required: true,
                  ),
                  FormTextField(
                    label: 'Senha*',
                    controller: _userPasswordController,
                    required: true,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        userDetails.name = _userNameController.text;
                        userDetails.email = _userEmailController.text;
                        userDetails.password = _userPasswordController.text;

                        var url = Uri.http('10.0.2.2:8080', '/users');
                        var response = await http.post(
                          url,
                          headers: {"content-type": "application/json"},
                          body: jsonEncode(userDetails),
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
