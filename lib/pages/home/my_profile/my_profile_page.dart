import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/ModelProvider.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildUsername(context),
    );
  }

  Widget _buildUsername(BuildContext context) {
    return FutureBuilder(
      future: _getMyUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User user = snapshot.data[0];
          return Text(user.name);
        }
        return Text('');
      },
    );
  }

  Future<List<User>> _getMyUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return await Amplify.DataStore.query(User.classType,
        where: User.NAME.eq(authUser.username));
  }
}
