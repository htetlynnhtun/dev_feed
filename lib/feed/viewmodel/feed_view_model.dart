import 'package:dev_feed/feed/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_view_model.freezed.dart';
part 'feedviewstate.dart';

final class FeedViewModel extends ValueNotifier<FeedViewState> {
  final PostLoader _loader;
  var _isDisposed = false;

  FeedViewModel({required PostLoader loader})
      : _loader = loader,
        super(const FeedViewState.loading());

  void load() async {
    value = const FeedViewState.loading();
    try {
      final posts = await _loader.load();
      value = FeedViewState.loaded(posts);
    } on Exception catch (_) {
      value = const FeedViewState.failure(
        'Please check your connection and try again',
      );
    }
  }

  @override
  set value(FeedViewState newValue) {
    if (_isDisposed) return;
    super.value = newValue;
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
