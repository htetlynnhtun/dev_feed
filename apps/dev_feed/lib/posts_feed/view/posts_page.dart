import 'package:dev_feed/posts_feed/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/posts_failure_view.dart';
import 'package:dev_feed/posts_feed/view/posts_loading_view.dart';

part 'posts_page.freezed.dart';

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
        child: Consumer(builder: (context, ref, child) {
          final paginatedPostsNotifier =
              ref.read(paginatedPostsNotifierProvider.notifier);
          final paginatedPosts = ref.watch(paginatedPostsNotifierProvider);

          return RefreshIndicator(
            onRefresh: paginatedPostsNotifier.load,
            child: switch (paginatedPosts) {
              AsyncValue(hasValue: true, :var value) => loadedView(
                  context,
                  value!.posts,
                  paginatedPostsNotifier.loadMorePosts,
                ),
              AsyncError() => Center(
                  child: PostsFailureView(
                    key: const ValueKey('post-failure-view'),
                    message: 'Failed to load posts. Please try again.',
                    onTapRetry: paginatedPostsNotifier.load,
                  ),
                ),
              _ => const Center(
                  child: PostsLoadingView(
                    key: ValueKey('post-loading-view'),
                  ),
                ),
            },
          );
        }),
      ),
    );
  }
}

@freezed
sealed class PostsPageState with _$PostsPageState {
  const factory PostsPageState.idle() = Idle;
  const factory PostsPageState.loading() = Loading;
  const factory PostsPageState.loaded(List<Post> posts) = Loaded;
  const factory PostsPageState.failure(String message) = failure;
}
