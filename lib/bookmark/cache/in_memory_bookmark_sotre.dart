import 'dart:async';

import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:rxdart/rxdart.dart';

import 'bookmark_store.dart';

class InMemoryBookmarkSotre implements BookmarkStore {
  final _bookmarksSubject = BehaviorSubject<List<Bookmark>>.seeded([]);

  @override
  Future<void> insert(Bookmark bookmark) async {
    _bookmarksSubject.add([..._bookmarksSubject.value, bookmark]);
  }

  @override
  Future<void> delete(Bookmark bookmark) async {
    final currentBookmarks = _bookmarksSubject.value;
    currentBookmarks.removeWhere((e) => e.id == bookmark.id);
    _bookmarksSubject.add(currentBookmarks);
  }

  @override
  Future<void> deleteById(String id) async {
    final currentBookmarks = _bookmarksSubject.value;
    currentBookmarks.removeWhere((e) => e.post.id == int.parse(id));
    _bookmarksSubject.add(currentBookmarks);
  }

  @override
  Stream<List<Bookmark>> retrieveAll() {
    return _bookmarksSubject;
  }
}
