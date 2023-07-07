import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputFieldWidget extends StatelessWidget {
  TextEditingController inputController;
  String label;
  TextInputType type;
  bool isPassword = false;
  InputFieldWidget(
      {super.key,
      required this.inputController,
      required this.label,
      required this.type,
      bool? isPass}) {
    isPassword = isPass ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your $label please..';
          }
          return null;
        },
        obscureText: isPassword,
        keyboardType: type,
        controller: inputController,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
