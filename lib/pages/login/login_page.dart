import 'package:flutter/material.dart';
import 'package:social_media_app/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: LoginForm(),
    );
  }
}
