import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home/feed/feed_list.dart';
import 'package:social_media_app/services/data_store/post_service.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: PostService.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FeedList(
                posts: snapshot.data,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
