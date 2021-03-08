import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const MyElevatedButton({Key key, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
