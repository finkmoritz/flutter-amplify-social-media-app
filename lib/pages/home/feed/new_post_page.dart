import 'package:flutter/material.dart';
import 'package:social_media_app/components/card/post_card.dart';
import 'package:social_media_app/models/Post.dart';
import 'package:social_media_app/services/data_store/post_service.dart';
import 'package:social_media_app/services/data_store/user_service.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  PostCard _postCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: UserService.getMyUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  _postCard = PostCard(
                    post: Post(
                      user: snapshot.data,
                      text: 'New Post',
                    ),
                    editable: true,
                  );
                  return _postCard;
                }
                return Container();
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save,
        ),
        onPressed: _savePost,
      ),
    );
  }

  _savePost() async {
    await PostService.save(_postCard.post);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successfully created post!')));
    Navigator.pop(context);
  }
}
