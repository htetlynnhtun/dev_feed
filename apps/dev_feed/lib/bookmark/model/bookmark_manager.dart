import 'package:dev_feed/bookmark/cache/bookmark_store.dart';
import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/bookmark/model/bookmark_creator.dart';
import 'package:dev_feed/bookmark/model/bookmark_deleter.dart';
import 'package:dev_feed/posts_feed/model/post.dart';
import 'package:uuid/uuid.dart';

class BookmarkManager implements BookmarkCreator, BookmarkDeleter {
  final BookmarkStore _store;

  BookmarkManager(this._store);

  static const _uuid = Uuid();

  Stream<List<Bookmark>> loadAll() {
    return _store.retrieveAll();
  }

  @override
  Future<void> createWith(Post post) async {
    final bookmark = Bookmark(id: _uuid.v4(), post: post);
    await _store.insert(bookmark);
  }

  @override
  Future<void> deleteById(String id) async {
    await _store.deleteById(id);
  }
}
