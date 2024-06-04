import 'package:dev_feed/feed/model/model.dart';

final class PostLoaderCacheDecorator implements PostLoader {
  final PostLoader decoratee;
  final PostCache cache;

  PostLoaderCacheDecorator({
    required this.decoratee,
    required this.cache,
  });

  @override
  Future<List<Post>> load() async {
    final posts = await decoratee.load();
    await cache.save(posts);
    return posts;
  }
}
