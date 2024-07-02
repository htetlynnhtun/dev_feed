// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostDetails {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  List<String> get tagList => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostDetailsCopyWith<PostDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailsCopyWith<$Res> {
  factory $PostDetailsCopyWith(
          PostDetails value, $Res Function(PostDetails) then) =
      _$PostDetailsCopyWithImpl<$Res, PostDetails>;
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String? coverImage,
      List<String> tagList,
      int likeCount,
      DateTime publishedAt,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$PostDetailsCopyWithImpl<$Res, $Val extends PostDetails>
    implements $PostDetailsCopyWith<$Res> {
  _$PostDetailsCopyWithImpl(this._value, this._then);

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
    Object? tagList = null,
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
      tagList: null == tagList
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PostDetailsImplCopyWith<$Res>
    implements $PostDetailsCopyWith<$Res> {
  factory _$$PostDetailsImplCopyWith(
          _$PostDetailsImpl value, $Res Function(_$PostDetailsImpl) then) =
      __$$PostDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String? coverImage,
      List<String> tagList,
      int likeCount,
      DateTime publishedAt,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$PostDetailsImplCopyWithImpl<$Res>
    extends _$PostDetailsCopyWithImpl<$Res, _$PostDetailsImpl>
    implements _$$PostDetailsImplCopyWith<$Res> {
  __$$PostDetailsImplCopyWithImpl(
      _$PostDetailsImpl _value, $Res Function(_$PostDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? coverImage = freezed,
    Object? tagList = null,
    Object? likeCount = null,
    Object? publishedAt = null,
    Object? user = null,
  }) {
    return _then(_$PostDetailsImpl(
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
      tagList: null == tagList
          ? _value._tagList
          : tagList // ignore: cast_nullable_to_non_nullable
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

class _$PostDetailsImpl implements _PostDetails {
  _$PostDetailsImpl(
      {required this.id,
      required this.title,
      required this.body,
      required this.coverImage,
      required final List<String> tagList,
      required this.likeCount,
      required this.publishedAt,
      required this.user})
      : _tagList = tagList;

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
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
  final int likeCount;
  @override
  final DateTime publishedAt;
  @override
  final User user;

  @override
  String toString() {
    return 'PostDetails(id: $id, title: $title, body: $body, coverImage: $coverImage, tagList: $tagList, likeCount: $likeCount, publishedAt: $publishedAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      body,
      coverImage,
      const DeepCollectionEquality().hash(_tagList),
      likeCount,
      publishedAt,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailsImplCopyWith<_$PostDetailsImpl> get copyWith =>
      __$$PostDetailsImplCopyWithImpl<_$PostDetailsImpl>(this, _$identity);
}

abstract class _PostDetails implements PostDetails {
  factory _PostDetails(
      {required final int id,
      required final String title,
      required final String body,
      required final String? coverImage,
      required final List<String> tagList,
      required final int likeCount,
      required final DateTime publishedAt,
      required final User user}) = _$PostDetailsImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String? get coverImage;
  @override
  List<String> get tagList;
  @override
  int get likeCount;
  @override
  DateTime get publishedAt;
  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$PostDetailsImplCopyWith<_$PostDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
