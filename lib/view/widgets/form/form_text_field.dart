import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const FormTextField({super.key, required this.label, required this.controller});

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