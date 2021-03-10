import 'package:amplify_flutter/amplify.dart';
import 'package:social_media_app/models/Post.dart';
import 'package:social_media_app/models/User.dart';
import 'package:social_media_app/services/data_store/user_service.dart';

class PostService {
  static Future<void> save(Post post) async {
    return Amplify.DataStore.save(post);
  }

  static Future<List<Post>> getAll() async {
    User user = await UserService.getMyUser();
    return Amplify.DataStore.query(Post.classType, where: User.ID.eq(user.id));
  }
}
