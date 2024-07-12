import 'package:dev_feed/bookmark/cache/bookmark_store.dart';

abstract class BookmarkDeleter {
  Future<void> deleteById(String id);
}

class BookmarkDeleterImpl implements BookmarkDeleter {
  final BookmarkStore _store;

  BookmarkDeleterImpl(this._store);

  @override
  Future<void> deleteById(String id) async {
    await _store.deleteById(id);
  }
}
