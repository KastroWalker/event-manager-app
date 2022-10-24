import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;

  const FormTextField({super.key, required this.label, required this.controller, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (required) return "Campo obrigatório";
            return null;
          }
        }
      ),
    );
  }
}