import 'package:flutter/material.dart';

class PostsFailureView extends StatelessWidget {
  const PostsFailureView({
    super.key,
    required this.message,
    required this.onTapRetry,
  });

  final String message;
  final VoidCallback onTapRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message),
        IconButton.filled(
          key: const ValueKey('retry-load-post-button'),
          onPressed: onTapRetry,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
