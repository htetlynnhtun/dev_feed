// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  List<String> get tagList => throw _privateConstructorUsedError;
  int get readingTimeMinutes => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'public_reactions_count')
  int get likeCount => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String? coverImage,
      List<String> tagList,
      int readingTimeMinutes,
      DateTime publishedAt,
      @JsonKey(name: 'public_reactions_count') int likeCount,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? coverImage = freezed,
    Object? tagList = null,
    Object? readingTimeMinutes = null,
    Object? publishedAt = null,
    Object? likeCount = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tagList: null == tagList
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      readingTimeMinutes: null == readingTimeMinutes
          ? _value.readingTimeMinutes
          : readingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String? coverImage,
      List<String> tagList,
      int readingTimeMinutes,
      DateTime publishedAt,
      @JsonKey(name: 'public_reactions_count') int likeCount,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? coverImage = freezed,
    Object? tagList = null,
    Object? readingTimeMinutes = null,
    Object? publishedAt = null,
    Object? likeCount = null,
    Object? user = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tagList: null == tagList
          ? _value._tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      readingTimeMinutes: null == readingTimeMinutes
          ? _value.readingTimeMinutes
          : readingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  _$PostImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.coverImage,
      required final List<String> tagList,
      required this.readingTimeMinutes,
      required this.publishedAt,
      @JsonKey(name: 'public_reactions_count') required this.likeCount,
      required this.user})
      : _tagList = tagList;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? coverImage;
  final List<String> _tagList;
  @override
  List<String> get tagList {
    if (_tagList is EqualUnmodifiableListView) return _tagList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagList);
  }

  @override
  final int readingTimeMinutes;
  @override
  final DateTime publishedAt;
  @override
  @JsonKey(name: 'public_reactions_count')
  final int likeCount;
  @override
  final User user;

  @override
  String toString() {
    return 'Post(id: $id, title: $title, description: $description, coverImage: $coverImage, tagList: $tagList, readingTimeMinutes: $readingTimeMinutes, publishedAt: $publishedAt, likeCount: $likeCount, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            (identical(other.readingTimeMinutes, readingTimeMinutes) ||
                other.readingTimeMinutes == readingTimeMinutes) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      coverImage,
      const DeepCollectionEquality().hash(_tagList),
      readingTimeMinutes,
      publishedAt,
      likeCount,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required final int id,
      required final String title,
      required final String description,
      required final String? coverImage,
      required final List<String> tagList,
      required final int readingTimeMinutes,
      required final DateTime publishedAt,
      @JsonKey(name: 'public_reactions_count') required final int likeCount,
      required final User user}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get coverImage;
  @override
  List<String> get tagList;
  @override
  int get readingTimeMinutes;
  @override
  DateTime get publishedAt;
  @override
  @JsonKey(name: 'public_reactions_count')
  int get likeCount;
  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
