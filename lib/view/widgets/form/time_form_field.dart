import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TimeFormField extends StatelessWidget {
  final mask = MaskTextInputFormatter(mask: "##:##");
  final String label;
  final TextEditingController controller;

  TimeFormField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        inputFormatters: [mask],
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          final components = value.split(":");
          if (components.length == 2) {
            final hour = int.tryParse(components[0]);
            final minute = int.tryParse(components[1]);
            if (hour != null && minute != null) {
              final isValidHour = hour >= 0 || hour <= 24;
              final isValidMinute = minute >= 0 || minute <= 60;
              if (isValidHour && isValidMinute) return null;
            }
          }
          return "Horário inválido";
        },
      ),
    );
  }
}