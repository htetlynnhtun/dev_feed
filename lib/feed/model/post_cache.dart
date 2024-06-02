import 'package:dev_feed/feed/model/model.dart';

abstract class PostCache {
  Future<void> save(List<Post> posts);
}
