import 'package:dev_feed/posts_feed/model/post.dart';

abstract class PostLoader {
  Future<List<Post>> load();
}
