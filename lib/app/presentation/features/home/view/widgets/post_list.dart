import 'package:flutter/material.dart';
import 'package:news_app/app/data/models/post_model.dart';

import 'post_list_item.dart';

class PostList extends StatelessWidget {
  final List<PostModel> posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostListItem(post: post);
      },
    );
  }
}
