import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const MyTextButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
