import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                      return 'Password too short';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your password'
                  ),
                ),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
