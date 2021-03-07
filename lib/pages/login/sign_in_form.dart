import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
              controller: usernameController,
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
                      print('Username: ${usernameController.text}');
                      print('Password: ${passwordController.text}');
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
