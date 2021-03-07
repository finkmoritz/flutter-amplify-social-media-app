import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

class SignInForm extends StatefulWidget {
  final initialUsername;
  final initialPassword;

  const SignInForm({Key key, this.initialUsername, this.initialPassword})
      : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _passwordController = TextEditingController(text: widget.initialPassword);
  }

  @override
  dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
            controller: _usernameController,
            validator: (value) {
              if (value.length < 5) {
                return 'Username too short';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter your username'),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value.length < 8) {
                return 'Password too short';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter your password'),
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
              TextButton(
                child: Text(
                  'Reset Password',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/resetPassword');
                },
              ),
              ElevatedButton(
                child: Text('Sign In'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      var username = _usernameController.text.trim();
                      var password = _passwordController.text.trim();
                      var result = await AuthService.signIn(
                        username: username,
                        password: password,
                      );
                      if (result.isSignedIn) {
                        SharedPreferencesService.setUsername(username);
                        SharedPreferencesService.setPassword(password);
                        Navigator.pushNamed(context, '/home');
                      }
                    } on AuthException catch (e) {
                      print(e.message);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    }
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
