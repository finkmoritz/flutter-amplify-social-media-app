import 'package:flutter/material.dart';
import 'package:social_media_app/models/Post.dart';
import 'package:social_media_app/pages/home/feed/feed_list.dart';
import 'package:social_media_app/services/data_store/post_service.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Future<List<Post>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = PostService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _posts = PostService.getAll();
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return FeedList(
                  posts: snapshot.data,
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
