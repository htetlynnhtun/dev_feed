// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_post_details_loader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostDetailsDto _$PostDetailsDtoFromJson(Map<String, dynamic> json) {
  return _PostDetailsDto.fromJson(json);
}

/// @nodoc
mixin _$PostDetailsDto {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'body_markdown')
  String get body => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'public_reactions_count')
  int get likeCount => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostDetailsDtoCopyWith<PostDetailsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailsDtoCopyWith<$Res> {
  factory $PostDetailsDtoCopyWith(
          PostDetailsDto value, $Res Function(PostDetailsDto) then) =
      _$PostDetailsDtoCopyWithImpl<$Res, PostDetailsDto>;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'body_markdown') String body,
      String? coverImage,
      List<String> tags,
      @JsonKey(name: 'public_reactions_count') int likeCount,
      DateTime publishedAt,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$PostDetailsDtoCopyWithImpl<$Res, $Val extends PostDetailsDto>
    implements $PostDetailsDtoCopyWith<$Res> {
  _$PostDetailsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? coverImage = freezed,
    Object? tags = null,
    Object? likeCount = null,
    Object? publishedAt = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostDetailsDtoImplCopyWith<$Res>
    implements $PostDetailsDtoCopyWith<$Res> {
  factory _$$PostDetailsDtoImplCopyWith(_$PostDetailsDtoImpl value,
          $Res Function(_$PostDetailsDtoImpl) then) =
      __$$PostDetailsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'body_markdown') String body,
      String? coverImage,
      List<String> tags,
      @JsonKey(name: 'public_reactions_count') int likeCount,
      DateTime publishedAt,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$PostDetailsDtoImplCopyWithImpl<$Res>
    extends _$PostDetailsDtoCopyWithImpl<$Res, _$PostDetailsDtoImpl>
    implements _$$PostDetailsDtoImplCopyWith<$Res> {
  __$$PostDetailsDtoImplCopyWithImpl(
      _$PostDetailsDtoImpl _value, $Res Function(_$PostDetailsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? coverImage = freezed,
    Object? tags = null,
    Object? likeCount = null,
    Object? publishedAt = null,
    Object? user = null,
  }) {
    return _then(_$PostDetailsDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostDetailsDtoImpl implements _PostDetailsDto {
  _$PostDetailsDtoImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'body_markdown') required this.body,
      required this.coverImage,
      required final List<String> tags,
      @JsonKey(name: 'public_reactions_count') required this.likeCount,
      required this.publishedAt,
      required this.user})
      : _tags = tags;

  factory _$PostDetailsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostDetailsDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'body_markdown')
  final String body;
  @override
  final String? coverImage;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'public_reactions_count')
  final int likeCount;
  @override
  final DateTime publishedAt;
  @override
  final User user;

  @override
  String toString() {
    return 'PostDetailsDto(id: $id, title: $title, body: $body, coverImage: $coverImage, tags: $tags, likeCount: $likeCount, publishedAt: $publishedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailsDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, coverImage,
      const DeepCollectionEquality().hash(_tags), likeCount, publishedAt, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailsDtoImplCopyWith<_$PostDetailsDtoImpl> get copyWith =>
      __$$PostDetailsDtoImplCopyWithImpl<_$PostDetailsDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostDetailsDtoImplToJson(
      this,
    );
  }
}

abstract class _PostDetailsDto implements PostDetailsDto {
  factory _PostDetailsDto(
      {required final int id,
      required final String title,
      @JsonKey(name: 'body_markdown') required final String body,
      required final String? coverImage,
      required final List<String> tags,
      @JsonKey(name: 'public_reactions_count') required final int likeCount,
      required final DateTime publishedAt,
      required final User user}) = _$PostDetailsDtoImpl;

  factory _PostDetailsDto.fromJson(Map<String, dynamic> json) =
      _$PostDetailsDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'body_markdown')
  String get body;
  @override
  String? get coverImage;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'public_reactions_count')
  int get likeCount;
  @override
  DateTime get publishedAt;
  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$PostDetailsDtoImplCopyWith<_$PostDetailsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
