import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/button/my_text_button.dart';
import 'package:social_media_app/components/dialog/loading_dialog.dart';
import 'package:social_media_app/components/dialog/ok_dialog.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

class SettingsListView extends StatefulWidget {
  @override
  _SettingsListViewState createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildThemeSwitch(),
        MyTextButton(
          child: Text('Change Password'),
          onPressed: () => Navigator.pushNamed(context, '/changePassword'),
        ),
        MyTextButton(
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

  _buildThemeSwitch() {
    Map<ThemeMode, String> themeModes = {
      ThemeMode.dark: 'Dark',
      ThemeMode.light: 'Light',
      ThemeMode.system: 'System Default',
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('App Theme'),
        FutureBuilder(
          future: SharedPreferencesService.getThemeMode(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DropdownButton(
                value: snapshot.data,
                items: themeModes.entries
                    .map((entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != snapshot.data) {
                    setState(() {
                      SharedPreferencesService.setThemeMode(value);
                    });
                    OkDialog.show(
                      context: context,
                      title: 'App Theme',
                      content:
                          'The app theme will change when this app is being closed and reopened.',
                    );
                  }
                },
              );
            } else {
              return DropdownButton(items: []);
            }
          },
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
