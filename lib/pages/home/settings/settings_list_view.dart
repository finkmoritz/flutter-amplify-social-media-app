import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/util/dialog/loading_dialog.dart';

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
          child: Text('Change Password'),
          onPressed: () => Navigator.pushNamed(context, '/changePassword'),
        ),
        TextButton(
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: _signOut,
        ),
      ],
    );
  }

  _signOut() async {
    bool success = false;
    try {
      LoadingDialog.show(
        context: context,
        text: 'Signing out',
      );
      await AuthService.signOut();
      success = true;
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      Navigator.pop(context); //close LoadingDialog
    }

    if (success) {
      Navigator.pushNamed(context, '/');
    }
  }
}
