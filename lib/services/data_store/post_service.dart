import 'package:amplify_flutter/amplify.dart';
import 'package:social_media_app/models/Post.dart';

class PostService {
  static Future<void> save(Post post) async {
    return Amplify.DataStore.save(post);
  }

  static Future<List<Post>> getAll() async {
    return Amplify.DataStore.query(Post.classType);
  }
}
