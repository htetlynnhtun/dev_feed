// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_post_details_loader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostDetailsDtoImpl _$$PostDetailsDtoImplFromJson(Map<String, dynamic> json) =>
    _$PostDetailsDtoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body_markdown'] as String,
      coverImage: json['cover_image'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      likeCount: (json['public_reactions_count'] as num).toInt(),
      publishedAt: DateTime.parse(json['published_at'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostDetailsDtoImplToJson(
        _$PostDetailsDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body_markdown': instance.body,
      'cover_image': instance.coverImage,
      'tags': instance.tags,
      'public_reactions_count': instance.likeCount,
      'published_at': instance.publishedAt.toIso8601String(),
      'user': instance.user.toJson(),
    };
