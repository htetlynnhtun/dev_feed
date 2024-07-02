import 'package:uuid/uuid.dart';

import 'package:dev_feed/bookmark/cache/bookmark_store.dart';
import 'package:dev_feed/bookmark/model/bookmark.dart';
import 'package:dev_feed/posts_feed/model/model.dart';

const uuid = Uuid();

abstract class BookmarkCreator {
  Future<void> createWith(Post post);
}

class BookmarkCreatorImpl implements BookmarkCreator {
  final BookmarkStore _store;

  BookmarkCreatorImpl(this._store);

  @override
  Future<void> createWith(Post post) async {
    final bookmark = Bookmark(id: uuid.v4(), post: post);
    await _store.insert(bookmark);
  }
}
