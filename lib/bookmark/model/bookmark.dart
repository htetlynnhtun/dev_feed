import 'package:dev_feed/posts_feed/model/model.dart';

class Bookmark {
  final String id;
  final Post post;

  Bookmark({required this.id, required this.post});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bookmark && other.post.id == post.id;
  }

  @override
  int get hashCode => post.id.hashCode;

  @override
  String toString() => 'Bookmark(id: $id)';
}
