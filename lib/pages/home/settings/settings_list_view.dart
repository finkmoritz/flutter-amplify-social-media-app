import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';

class SettingsListView extends StatefulWidget {
  @override
  _SettingsListViewState createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: _signOut,
        ),
      ],
    );
  }

  _signOut() async {
    try {
      await AuthService.signOut();
      Navigator.pushNamed(context, '/');
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
