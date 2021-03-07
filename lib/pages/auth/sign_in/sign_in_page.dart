import 'package:flutter/material.dart';
import 'package:social_media_app/pages/auth/sign_in/sign_in_form.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media App'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: Future.wait([
          SharedPreferencesService.getUsername(),
          SharedPreferencesService.getPassword(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildContent(
              username: snapshot.data[0],
              password: snapshot.data[1],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildContent({String username, String password}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage('assets/icon.png')),
            SignInForm(
              initialUsername: username,
              initialPassword: password,
            ),
          ],
        ),
      ),
    );
  }
}
