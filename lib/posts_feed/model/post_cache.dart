import 'package:dev_feed/posts_feed/model/model.dart';

abstract class PostCache {
  Future<void> save(List<Post> posts);
}
