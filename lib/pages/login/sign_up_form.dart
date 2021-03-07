import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if(!_emailRegEx.hasMatch(value)) {
                  return 'Invalid email address';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email address'
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if(value.length < 5) {
                  return 'Username too short';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your username'
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if(value.length < 5) {
                  return 'Password too short';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your password'
              ),
            ),
            ElevatedButton(
              child: Text('Sign Up'),
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
          ],
        ),
    );
  }
}
