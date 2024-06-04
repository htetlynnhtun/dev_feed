import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/feed/viewmodel/post_item_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'posts_view_model.freezed.dart';
part 'posts_view_state.dart';

final class PostsViewModel extends ValueNotifier<PostsViewState> {
  final PostLoader _loader;
  final PostItemViewModel Function(Post) postViewModelFactory;
  var _isDisposed = false;

  PostsViewModel({
    required PostLoader loader,
    required this.postViewModelFactory,
  })  : _loader = loader,
        super(const PostsViewState.loading());

  void load() async {
    value = const PostsViewState.loading();
    try {
      final posts = await _loader.load();
      value = PostsViewState.loaded(posts.map(postViewModelFactory).toList());
    } on Exception catch (_) {
      value = const PostsViewState.failure(
        'Please check your connection and try again',
      );
    }
  }

  @override
  set value(PostsViewState newValue) {
    if (_isDisposed) return;
    super.value = newValue;
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
