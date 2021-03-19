import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintName;
  final String validation;
  final TextInputType textInputType;

  const CustomTextField(
      {Key key,
      this.controller,
      this.hintName,
      this.validation,
      this.textInputType:TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: getInputDecoration(hintName),
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        if (val.length == 0) return validation;
        return null;
      },
    );
  }

  getInputDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), gapPadding: 4));
  }
}
