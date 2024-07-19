import 'package:dev_feed/posts_feed/cubit/posts_feed_cubit.dart';
import 'package:flutter/material.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/posts_failure_view.dart';
import 'package:dev_feed/posts_feed/view/posts_loading_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    List<Post> posts,
    void Function()? loadMore,
  ) loadedView;

  const PostsPage({
    super.key,
    required this.loadedView,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: context.read<PostsFeedCubit>().load,
          child: BlocBuilder<PostsFeedCubit, PostsFeedState>(
            builder: (context, state) {
              return switch (state) {
                Idle() || Loading() => const Center(
                    child: PostsLoadingView(
                      key: ValueKey('post-loading-view'),
                    ),
                  ),
                Loaded(:var posts) => loadedView(
                    context,
                    posts,
                    context.read<PostsFeedCubit>().loadMorePosts,
                  ),
                Failure(:var message) => Center(
                    child: PostsFailureView(
                      key: const ValueKey('post-failure-view'),
                      message: message,
                      onTapRetry: context.read<PostsFeedCubit>().load,
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
