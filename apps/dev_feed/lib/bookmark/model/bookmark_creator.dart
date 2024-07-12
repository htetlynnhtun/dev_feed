import 'package:dev_feed/posts_feed/model/model.dart';

abstract class BookmarkCreator {
  Future<void> createWith(Post post);
}
