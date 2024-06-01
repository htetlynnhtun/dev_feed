import 'package:dev_feed/feed/model/post.dart';

abstract class PostLoader {
  Future<List<Post>> load();
}
