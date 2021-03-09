import 'package:flutter/material.dart';
import 'package:social_media_app/components/form/my_text_form_field.dart';
import 'package:social_media_app/models/Post.dart';

class PostCard extends StatefulWidget {
  Post post;
  final bool editable;

  PostCard({Key key, this.post, this.editable = false}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.post.text);
    _controller.addListener(() {
      widget.post = widget.post.copyWith(text: _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.post.user.name ?? 'Unknown User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.editable
                ? MyTextFormField(
                    controller: _controller,
                  )
                : Text(widget.post.text),
          ],
        ),
      ),
    );
  }
}
