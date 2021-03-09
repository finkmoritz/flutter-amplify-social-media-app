import 'package:flutter/material.dart';
import 'package:social_media_app/components/card/post_card.dart';
import 'package:social_media_app/models/Post.dart';

class FeedList extends StatelessWidget {
  final List<Post> posts;

  const FeedList({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            post: posts[index],
          );
        });
  }
}
