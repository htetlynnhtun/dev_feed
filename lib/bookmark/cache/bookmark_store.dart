import 'package:dev_feed/bookmark/model/bookmark.dart';

abstract class BookmarkStore {
  Future<void> insert(Bookmark bookmark);
  Future<void> delete(Bookmark bookmark);
  Future<void> deleteById(String id);
  Stream<List<Bookmark>> retrieveAll();
}
