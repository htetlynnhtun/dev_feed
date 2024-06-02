import 'package:dev_feed/feed/cache/post_store.dart';
import 'package:dev_feed/feed/model/model.dart';

final class LocalPostLoader implements PostLoader, PostCache {
  final PostStore _postStore;

  LocalPostLoader({
    required PostStore postStore,
  }) : _postStore = postStore;

  @override
  Future<void> save(List<Post> posts) async {
    await _postStore.deleteCachedPosts();
    await _postStore.insert(posts);
  }

  @override
  Future<List<Post>> load() {
    return _postStore.retrieve();
  }
}
