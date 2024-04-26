import 'package:flutter/material.dart';

Widget buildInputField({
  required String initialValue,
  required String labelText,
  required IconData prefixIcon,
  TextInputType? keyboardType,
  required Function(String) onChanged,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    ),
  );
}
