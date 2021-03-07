import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/login_service.dart';

class SignUpConfirmationForm extends StatefulWidget {
  final TextEditingController usernameController;

  SignUpConfirmationForm({Key key, this.usernameController}) : super(key: key);

  @override
  _SignUpConfirmationFormState createState() => _SignUpConfirmationFormState();
}

class _SignUpConfirmationFormState extends State<SignUpConfirmationForm> {
  final _formKey = GlobalKey<FormState>();
  final confirmationCodeController = TextEditingController();

  @override
  void dispose() {
    confirmationCodeController.dispose();
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
            controller: confirmationCodeController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the confirmation code';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter confirmation code'),
          ),
          ElevatedButton(
            child: Text('Confirm'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  var result = await LoginService.confirmSignUp(
                    username: widget.usernameController.text.trim(),
                    confirmationCode: confirmationCodeController.text.trim(),
                  );
                  if (result.isSignUpComplete) {
                    Navigator.pushNamed(context, '/home');
                  }
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
