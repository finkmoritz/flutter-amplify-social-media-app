import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String Function(String) validator;
  final InputDecoration decoration;

  const MyTextFormField(
      {Key key,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.decoration = const InputDecoration()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: decoration,
    );
  }
}
