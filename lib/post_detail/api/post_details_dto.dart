part of 'remote_post_details_loader.dart';

@freezed
class PostDetailsDto with _$PostDetailsDto {
  factory PostDetailsDto({
    required int id,
    required String title,
    @JsonKey(name: 'body_markdown')
    required String body,
    required String? coverImage,
    required List<String> tags,
    @JsonKey(name: 'public_reactions_count')
    required int likeCount,
    required DateTime publishedAt,
    required User user,
  }) = _PostDetailsDto;

  factory PostDetailsDto.fromJson(Map<String, dynamic> json) => _$PostDetailsDtoFromJson(json);
}

extension on PostDetailsDto {
  PostDetails toDomain() => PostDetails(
        id: id,
        title: title,
        body: body,
        coverImage: coverImage,
        tagList: tags,
        likeCount: likeCount,
        publishedAt: publishedAt,
        user: user,
      );
}
