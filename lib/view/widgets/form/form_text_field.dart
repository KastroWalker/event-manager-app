import 'package:event_manager/domain.input_validators/input_validator.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final List<InputValidator>? validators;
  final String invalidValueMessage;

  const FormTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.required = false,
      this.validators,
      this.invalidValueMessage = ''});

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
            if (validators != null && validators!.isNotEmpty) {
              var isInvalidValue = false;
              validators?.forEach((validator) {
                if (!validator.validate(value)) isInvalidValue = true;
              });
              if (isInvalidValue) return invalidValueMessage;
            }
            return null;
          }
      ),
    );
  }
}