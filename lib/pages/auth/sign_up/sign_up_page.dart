import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _confirmationFormKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationCodeController = TextEditingController();

  final _emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  int _stepIndex = 0;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationCodeController.dispose();
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
              title: Text('Sign Up'),
              content: _buildSignUpForm(),
              isActive: _stepIndex == 0,
              state: _stepIndex > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: Text('Confirm'),
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
                      child: const Text('Sign Up'),
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
                    TextButton(
                      onPressed: _resend,
                      child: const Text('Resend Code'),
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
      key: _signUpFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (!_emailRegEx.hasMatch(value)) {
                return 'Invalid email address';
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Enter your email address'),
          ),
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
    if (_signUpFormKey.currentState.validate()) {
      try {
        await AuthService.signUp(
          email: _emailController.text.trim(),
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
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

  _resend() async {
    if (_confirmationFormKey.currentState.validate()) {
      try {
        await AuthService.resendConfirmationCode(
          username: _usernameController.text.trim(),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sent confirmation code')));
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
        var result = await AuthService.confirmSignUp(
          username: _usernameController.text.trim(),
          confirmationCode: _confirmationCodeController.text.trim(),
        );
        if (result.isSignUpComplete) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Successfully signed up!')));
          SharedPreferencesService.setUsername(_usernameController.text.trim());
          SharedPreferencesService.setPassword(_passwordController.text.trim());
          Navigator.pushNamed(context, '/');
        }
      } on AuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
