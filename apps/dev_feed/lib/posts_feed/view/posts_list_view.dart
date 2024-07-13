import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:flutter/material.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({
    super.key,
    required this.posts,
    required this.itemView,
    this.loadNextPage,
  });

  final List<Post> posts;
  final Widget Function(BuildContext context, Post post) itemView;
  final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          loadNextPage?.call();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: posts.length + (loadNextPage == null ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= posts.length) {
            return const LoadMoreIndicator();
          }

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
      ),
    );
  }
}

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
