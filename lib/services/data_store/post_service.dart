import 'package:amplify_flutter/amplify.dart';
import 'package:social_media_app/models/Post.dart';
import 'package:social_media_app/models/User.dart';
import 'package:social_media_app/services/data_store/user_service.dart';

class PostService {
  static Future<void> save(Post post) async {
    return Amplify.DataStore.save(post);
  }

  static Future<List<Post>> getAll() async {
    User myUser = await UserService.getMyUser();
    List<Post> posts = await Amplify.DataStore.query(Post.classType, where: User.ID.eq(myUser.id));
    List<Post> postsWithUsers = [];
    posts.forEach((post) async {
      List<User> users = await Amplify.DataStore.query(User.classType, where: User.ID.eq(post.user.id));
      postsWithUsers.add(post.copyWith(user: users[0]));
    });
    return postsWithUsers;
  }
}
