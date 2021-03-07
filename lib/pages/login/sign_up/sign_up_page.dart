import 'package:flutter/material.dart';
import 'package:social_media_app/pages/login/sign_up/sign_up_confirmation_form.dart';
import 'package:social_media_app/pages/login/sign_up/sign_up_form.dart';
import 'package:steps/steps.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Steps(
          direction: Axis.vertical,
          size: 20.0,
          path: {'color': Colors.lightBlue.shade200, 'width': 3.0},
          steps: [
            {
              'label': '1',
              'color': Colors.white,
              'background': Colors.lightBlue.shade200,
              'content': SignUpForm(
                usernameController: usernameController,
              ),
            },
            {
              'label': '2',
              'color': Colors.white,
              'background': Colors.lightBlue.shade400,
              'content': Text(
                  'Check your email inbox. We have sent you a mail with your confirmation code.'),
            },
            {
              'label': '3',
              'color': Colors.white,
              'background': Colors.blue,
              'content': SignUpConfirmationForm(
                usernameController: usernameController,
              ),
            }
          ],
        ),
      ),
    );
  }
}
