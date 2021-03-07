import 'package:flutter/material.dart';
import 'package:social_media_app/pages/auth/sign_in/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('assets/icon.png')),
              SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
