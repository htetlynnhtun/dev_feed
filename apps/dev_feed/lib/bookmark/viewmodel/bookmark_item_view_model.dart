import 'dart:async';

import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/bookmark/model/bookmark_deleter.dart';
import 'package:dev_feed/bookmark/model/bookmark_loader.dart';
import 'package:dev_feed/posts_feed/model/model.dart';
import 'package:flutter/foundation.dart';

typedef IsBookmarked = bool;

class BookmarkItemViewModel extends ValueNotifier<IsBookmarked> {
  final Post post;
  final BookmarkLoader loader;
  final BookmarkCreator creator;
  final BookmarkDeleter deleter;
  StreamSubscription? _subscription;

  BookmarkItemViewModel({
    required this.post,
    required this.loader,
    required this.creator,
    required this.deleter,
  }) : super(false) {
    _subscription = loader().listen((bookmarks) {
      final isPostBookmarked = bookmarks.any((e) => e.post.id == post.id);
      value = isPostBookmarked;
    });
  }

  void bookmark() {
    creator.createWith(post);
  }

  void unbookmark() {
    deleter.deleteById(post.id.toString());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
