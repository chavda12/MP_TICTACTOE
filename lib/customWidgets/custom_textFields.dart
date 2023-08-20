import 'package:flutter/material.dart';
import 'package:mp_tictactoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(spreadRadius: 2, blurRadius: 5, color: Colors.blue)
        ]),
        child: TextField(
          controller: controller,
          readOnly: isReadOnly,
          decoration: InputDecoration(
              fillColor: bgColor, filled: true, hintText: hintText),
        ));
  }
}
