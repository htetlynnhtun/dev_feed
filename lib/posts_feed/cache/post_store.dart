import 'package:dev_feed/posts_feed/model/model.dart';

abstract class PostStore {
  Future<void> deleteCachedPosts();
  Future<void> insert(List<Post> posts);
  Future<List<Post>> retrieve();
}
