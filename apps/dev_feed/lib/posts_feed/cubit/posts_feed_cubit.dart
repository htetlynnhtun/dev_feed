import 'dart:async';

import 'package:dev_feed/posts_feed/model/paginated_posts.dart';
import 'package:dev_feed/posts_feed/model/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_feed_cubit.freezed.dart';
part 'posts_feed_state.dart';

class PostsFeedCubit extends Cubit<PostsFeedState> {
  final Stream<PaginatedPosts> Function() postsStream;
  PostsFeedCubit(this.postsStream) : super(const PostsFeedState.idle());

  StreamSubscription? _subscription;
  VoidCallback? loadMorePosts;

  Future<void> load() async {
    final loadOperation = Completer();
    if (state case PostsFeedState.idle) {
      emit(const PostsFeedState.loading());
    }
    _subscription?.cancel();
    _subscription = postsStream().listen(
      _onData,
      onError: _onError,
      onDone: () => loadOperation.complete(),
    );
    return loadOperation.future;
  }

  void _onData(paginatedPosts) {
    emit(PostsFeedState.loaded(paginatedPosts.posts));
    final loadMore = paginatedPosts.loadMore;
    if (loadMore != null) {
      loadMorePosts = () {
        _subscription?.cancel();
        _subscription = loadMore().listen(
          _onData,
          onError: _onError,
        );
      };
    } else {
      loadMorePosts = null;
    }
  }

  void _onError(e) {
    emit(const PostsFeedState.failure(
      'Please check your connection and try again',
    ));
  }
}
