import 'package:flutter/material.dart';
import 'package:social_media_app/components/button/my_elevated_button.dart';

class OkDialog {
  static show({BuildContext context, String title, String content}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            MyElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
