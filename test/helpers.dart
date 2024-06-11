import 'package:dev_feed/feed/model/model.dart';
import 'package:dev_feed/shared/model/model.dart';

Post makePost({required int id}) {
  return Post(
    id: id,
    title: 'title',
    description: 'description',
    coverImage: 'coverImage',
    tagList: ['a', 'b'],
    readingTimeMinutes: 1,
    publishedAt: DateTime.now(),
    likeCount: 1,
    user: User(name: 'name', profileImage: 'image.com'),
  );
}

List<Post> uniquePosts() {
  return [
    makePost(id: 1),
    makePost(id: 2),
  ];
}
