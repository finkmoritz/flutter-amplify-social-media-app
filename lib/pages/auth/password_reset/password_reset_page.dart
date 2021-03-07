import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _resetFormKey = GlobalKey<FormState>();
  final _confirmationFormKey = GlobalKey<FormState>();

  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _confirmationCodeController;

  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmationCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Stepper(
          currentStep: _stepIndex,
          onStepCancel: () {
            if (_stepIndex > 0) {
              setState(() {
                _stepIndex--;
              });
            }
          },
          onStepContinue: () {
            if (_stepIndex < 1) {
              setState(() {
                _stepIndex++;
              });
            }
          },
          onStepTapped: (index) {
            if (_stepIndex != index) {
              setState(() {
                _stepIndex = index;
              });
            }
          },
          steps: [
            Step(
              title: Text('Reset Password'),
              content: _buildSignUpForm(),
              isActive: _stepIndex == 0,
              state: _stepIndex > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: Text('Confirm New Password'),
              content: _buildConfirmationForm(),
              isActive: _stepIndex == 1,
            ),
          ],
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            switch (_stepIndex) {
              case 0:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onStepContinue,
                      child: const Text('Skip'),
                    ),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Reset Password'),
                    ),
                  ],
                );
              case 1:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onStepCancel,
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: _confirm,
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              default:
                throw Exception('Index out of bounds: $_stepIndex');
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _resetFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _usernameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter your username'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationForm() {
    return Form(
      key: _confirmationFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'We sent you an email with your confirmation code. Please check your inbox.'),
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
          TextFormField(
            controller: _confirmationCodeController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the confirmation code';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter confirmation code'),
          ),
        ],
      ),
    );
  }

  _signUp() async {
    if (_resetFormKey.currentState.validate()) {
      try {
        await AuthService.resetPassword(
          username: _usernameController.text.trim(),
        );
        setState(() {
          _stepIndex = 1;
        });
      } on AuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  _confirm() async {
    if (_confirmationFormKey.currentState.validate()) {
      try {
        await AuthService.confirmPasswordReset(
          username: _usernameController.text.trim(),
          newPassword: _passwordController.text.trim(),
          confirmationCode: _confirmationCodeController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully reset password!')));
        SharedPreferencesService.setPassword(_passwordController.text.trim());
        Navigator.pushNamed(context, '/');
      } on AuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
