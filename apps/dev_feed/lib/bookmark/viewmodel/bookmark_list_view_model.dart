import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/model/bookmark_loader.dart';

part 'bookmark_list_view_model.freezed.dart';

class BookmarkListViewModel extends ValueNotifier<BookmarkListViewState> {
  final BookmarkLoader loader;
  StreamSubscription? _subscription;

  BookmarkListViewModel(this.loader) : super(const Pending()) {
    _subscription = loader().listen((bookmarks) {
      value = BookmarkListViewState.loaded(bookmarks);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

@freezed
sealed class BookmarkListViewState with _$BookmarkListViewState {
  const factory BookmarkListViewState.pending() = Pending;
  const factory BookmarkListViewState.loaded(List<Bookmark> bookmarks) = Loaded;
}
