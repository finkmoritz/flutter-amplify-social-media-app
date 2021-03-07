import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/login_service.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController usernameController;

  const SignUpForm({Key key, this.usernameController}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailRegEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    emailController.dispose();
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
            controller: widget.usernameController,
            validator: (value) {
              if (value.length < 5) {
                return 'Username too short';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter your username'),
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
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue.shade200,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                try {
                  LoginService.signUp(
                    email: emailController.text.trim(),
                    username: widget.usernameController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                } on AuthException catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.message)));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
