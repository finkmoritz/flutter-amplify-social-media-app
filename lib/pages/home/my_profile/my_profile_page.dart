import 'package:flutter/material.dart';
import 'package:social_media_app/components/card/user_card.dart';
import 'package:social_media_app/services/data_store/user_service.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildUserInfo(context),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return FutureBuilder(
      future: UserService.getMyUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return UserCard(user: snapshot.data);
        }
        return Container();
      },
    );
  }
}
