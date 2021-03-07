import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home/home_page.dart';
import 'package:social_media_app/pages/login/login_page.dart';
import 'package:social_media_app/pages/login/sign_in_form.dart';
import 'package:social_media_app/pages/login/sign_up_form.dart';

import 'amplifyconfiguration.dart';

class MyApp extends StatefulWidget {

  final String initialRoute;

  MyApp({Key key, this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!mounted) return;

    Amplify.addPlugin(AmplifyAuthCognito());

    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Amplify Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: widget.initialRoute,
        routes: {
          '/': (context) => LoginPage(
              title: 'Sign In',
              formWidget: SignInForm()
          ),
          '/signup': (context) => LoginPage(
              title: 'Sign Up',
              formWidget: SignUpForm()
          ),
          '/home': (context) => HomePage(),
        },
    );
  }
}
