import 'package:dev_feed/bookmark/cache/bookmark_store.dart';
import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/posts_feed/model/model.dart';

abstract class BookmarkDeleter {
  Future<void> deleteFor(Post post);
  Future<void> deleteById(String id);
}

class BookmarkDeleterImpl implements BookmarkDeleter {
  final BookmarkStore _store;

  BookmarkDeleterImpl(this._store);

  @override
  Future<void> deleteFor(Post post) async {
    final bookmark = Bookmark(id: uuid.v4(), post: post);
    await _store.insert(bookmark);
  }

  @override
  Future<void> deleteById(String id) async {
    await _store.deleteById(id);
  }
}
