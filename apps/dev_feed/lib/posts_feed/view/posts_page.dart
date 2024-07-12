import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:dev_feed/posts_feed/view/posts_failure_view.dart';
import 'package:dev_feed/posts_feed/view/posts_loading_view.dart';

part 'posts_page.freezed.dart';

class PostsPage extends StatefulWidget {
  final Stream<List<Post>> Function() postsStream;
  final Widget Function(BuildContext context, List<Post> posts) loadedView;

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

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      state = const PostsPageState.loading();
    });
    _subscription = widget.postsStream().listen(
      (posts) {
        setState(() {
          state = PostsPageState.loaded(posts);
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
            Loaded(posts: var posts) => widget.loadedView(context, posts),
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
