import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
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
              controller: usernameController,
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
              controller: passwordController,
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
                  print('Email: ${emailController.text}');
                  print('Username: ${usernameController.text}');
                  print('Password: ${passwordController.text}');
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
          ],
        ),
    );
  }
}
