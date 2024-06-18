import 'package:flutter/material.dart';

import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/view/posts_failure_view.dart';
import 'package:dev_feed/feed/view/posts_loading_view.dart';
import 'package:dev_feed/feed/viewmodel/posts_view_model.dart';

class PostsPage extends StatefulWidget {
  final PostsViewModel Function() viewModelFactory;
  final Widget Function(BuildContext context, List<Post> posts) loadedView;

  const PostsPage({
    super.key,
    required this.viewModelFactory,
    required this.loadedView,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late final PostsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModelFactory();
    viewModel.load();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: viewModel,
          builder: (context, value, child) {
            switch (value) {
              case Idle():
              case Loading():
                return const Center(
                  child: PostsLoadingView(
                    key: ValueKey('post-loading-view'),
                  ),
                );

              case Loaded(posts: var posts):
                return widget.loadedView(context, posts);

              case failure(message: var message):
                return Center(
                  child: PostsFailureView(
                    key: const ValueKey('post-failure-view'),
                    message: message,
                    onTapRetry: viewModel.load,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
