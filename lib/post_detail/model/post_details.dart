import 'package:dev_feed/shared/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_details.freezed.dart';

@freezed
class PostDetails with _$PostDetails {
  factory PostDetails({
    required int id,
    required String title,
    required String body,
    required String? coverImage,
    required List<String> tagList,
    required int likeCount,
    required DateTime publishedAt,
    required User user,
  }) = _PostDetails;
}
