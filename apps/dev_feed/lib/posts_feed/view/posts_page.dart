import 'dart:async';

import 'package:dev_feed/posts_feed/model/paginated_posts.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/posts_failure_view.dart';
import 'package:dev_feed/posts_feed/view/posts_loading_view.dart';

part 'posts_page.freezed.dart';

class PostsPage extends StatefulWidget {
  final Stream<PaginatedPosts> Function() postsStream;
  final Widget Function(
    BuildContext context,
    List<Post> posts,
    void Function()? loadMore,
  ) loadedView;

  const PostsPage({
    super.key,
    required this.postsStream,
    required this.loadedView,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var state = const PostsPageState.idle();
  StreamSubscription? _subscription;
  Stream<PaginatedPosts> Function()? morePostsPipeline;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      state = const PostsPageState.loading();
    });
    _subscription?.cancel();
    _subscription = widget.postsStream().listen(
      (paginatedPosts) {
        setState(() {
          state = PostsPageState.loaded(paginatedPosts.posts);
          morePostsPipeline = paginatedPosts.loadMore;
        });
      },
      onError: (e) {
        setState(() {
          state = const PostsPageState.failure(
            'Please check your connection and try again',
          );
        });
      },
    );
  }

  void loadMorePosts() {
    assert(
      morePostsPipeline != null,
      "Don't request to load more posts when "
      "there is no morePostsPipeline",
    );
    _subscription?.cancel();
    _subscription = morePostsPipeline!().listen(
      (paginatedPosts) {
        setState(() {
          state = PostsPageState.loaded(paginatedPosts.posts);
          morePostsPipeline = paginatedPosts.loadMore;
        });
      },
      onError: (e) {
        setState(() {
          state = const PostsPageState.failure(
            'Failed to load more posts',
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: load,
          child: switch (state) {
            Idle() || Loading() => const Center(
                child: PostsLoadingView(
                  key: ValueKey('post-loading-view'),
                ),
              ),
            Loaded(posts: var posts) => widget.loadedView(
                context,
                posts,
                morePostsPipeline == null ? null : loadMorePosts,
              ),
            failure(message: var message) => Center(
                child: PostsFailureView(
                  key: const ValueKey('post-failure-view'),
                  message: message,
                  onTapRetry: load,
                ),
              ),
          },
        ),
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
