import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                ),
                ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
    );
  }
}
