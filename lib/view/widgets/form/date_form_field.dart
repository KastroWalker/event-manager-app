import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateFormField extends StatelessWidget {
  final mask = MaskTextInputFormatter(mask: "##/##/####");
  final String label;
  final TextEditingController controller;

  DateFormField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        inputFormatters: [mask],
        controller: controller,
        decoration: InputDecoration(
          hintText: "dd/mm/yyyy",
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          final components = value.split("/");
          if (components.length == 3) {
            final day = int.tryParse(components[0]);
            final month = int.tryParse(components[1]);
            final year = int.tryParse(components[2]);
            if (day != null && month != null && year != null) {
              final date = DateTime(year, month, day);
              if (date.year == year && date.month == month && date.day == day) {
                return null;
              }
            }
          }
          return "Data inválida";
        },
      ),
    );
  }
}