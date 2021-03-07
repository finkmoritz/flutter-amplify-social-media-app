import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home/settings/settings_list_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsListView(),
    );
  }
}
