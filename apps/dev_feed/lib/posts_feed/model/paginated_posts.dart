import 'package:dev_feed/posts_feed/model/model.dart';

class PaginatedPosts {
  final List<Post> posts;
  final Stream<PaginatedPosts> Function()? loadMore;

  PaginatedPosts({
    required this.posts,
    this.loadMore,
  });
}
