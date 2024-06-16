import 'package:dev_feed/feed/model/model.dart';
import 'package:flutter/material.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({
    super.key,
    required this.posts,
    required this.itemView,
  });

  final List<Post> posts;
  final Widget Function(BuildContext context, Post post) itemView;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;
        var padding = const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        );
        if (isFirstItem) {
          padding += const EdgeInsets.only(top: 16.0);
        }
        return Padding(
          padding: padding,
          child: itemView(context, posts[index]),
        );
      },
    );
  }
}
