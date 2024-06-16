import 'package:flutter/material.dart';

class PostsLoadingView extends StatelessWidget {
  const PostsLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text('Loading posts...'),
      ],
    );
  }
}
