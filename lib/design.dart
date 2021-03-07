import 'package:flutter/material.dart';

getInputDecoration(String labelText) {
  return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 4
      ));
}