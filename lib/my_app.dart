import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/auth/password_reset/password_reset_page.dart';
import 'package:social_media_app/pages/auth/sign_in/sign_in_page.dart';
import 'package:social_media_app/pages/auth/sign_up/sign_up_page.dart';
import 'package:social_media_app/pages/home/home_page.dart';
import 'package:social_media_app/pages/home/settings/settings_page.dart';

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

    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAnalyticsPinpoint()]);

    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
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
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/resetPassword': (context) => PasswordResetPage(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
