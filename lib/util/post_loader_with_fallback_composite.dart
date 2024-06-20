import 'package:dev_feed/posts_feed/model/model.dart';

final class PostLoaderWithFallbackComposite implements PostLoader {
  final PostLoader primary;
  final PostLoader fallback;

  PostLoaderWithFallbackComposite({
    required this.primary,
    required this.fallback,
  });

  @override
  Future<List<Post>> load() async {
    try {
      final posts = await primary.load();
      return posts;
    } catch (_) {
      return fallback.load();
    }
  }
}
