// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tagList:
          (json['tag_list'] as List<dynamic>).map((e) => e as String).toList(),
      readingTimeMinutes: (json['reading_time_minutes'] as num).toInt(),
      publishedAt: DateTime.parse(json['published_at'] as String),
      likeCount: (json['public_reactions_count'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'tag_list': instance.tagList,
      'reading_time_minutes': instance.readingTimeMinutes,
      'published_at': instance.publishedAt.toIso8601String(),
      'public_reactions_count': instance.likeCount,
      'user': instance.user.toJson(),
    };
