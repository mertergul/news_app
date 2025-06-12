import 'package:flutter/material.dart';
import 'package:news_app/app/data/models/post_model.dart';

class PostListItem extends StatelessWidget {
  final PostModel post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(post.body),
      ),
    );
  }
}
