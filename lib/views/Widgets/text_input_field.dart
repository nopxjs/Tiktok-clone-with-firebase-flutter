// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:toktik/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.isObscure = false,
      this.borderradius = 5});

  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool isObscure;
  final borderradius;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
