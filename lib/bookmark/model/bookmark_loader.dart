import 'package:dev_feed/bookmark/model/bookmark.dart';

abstract class BookmarkLoader {
  Future<List<Bookmark>> loadAll();
}
