import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String title;
  final Widget formWidget;

  LoginPage({this.title, this.formWidget, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/icon.png')),
              formWidget,
            ],
          ),
        ),
      ),
    );
  }
}
