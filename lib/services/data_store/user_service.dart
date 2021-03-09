import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:social_media_app/models/User.dart';

class UserService {
  static Future<User> getMyUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    List<User> users = await Amplify.DataStore.query(User.classType,
        where: User.NAME.eq(authUser.username));
    return users[0];
  }
}
