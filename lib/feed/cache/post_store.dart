import 'package:dev_feed/feed/model/model.dart';

abstract class PostStore {
  Future<void> deleteCachedPosts();
  Future<void> insert(List<Post> posts);
  Future<List<Post>> retrieve();
}
