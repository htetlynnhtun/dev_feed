import 'package:dev_feed/feed/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    required String id,
    required String title,
    required String description,
    required List<String> tagList,
    required int readingTimeMinutes,
    required DateTime publishedAt,
    @JsonKey(name: 'public_reactions_count') //
    required int likeCount,
    required User user,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
