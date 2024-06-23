// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_item_view_model_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReceivedMessages {
  Post get post => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Post post) createWith,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Post post)? createWith,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Post post)? createWith,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWith value) createWith,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateWith value)? createWith,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWith value)? createWith,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$ReceivedMessagesCopyWith<_ReceivedMessages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReceivedMessagesCopyWith<$Res> {
  factory _$ReceivedMessagesCopyWith(
          _ReceivedMessages value, $Res Function(_ReceivedMessages) then) =
      __$ReceivedMessagesCopyWithImpl<$Res, _ReceivedMessages>;
  @useResult
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$ReceivedMessagesCopyWithImpl<$Res, $Val extends _ReceivedMessages>
    implements _$ReceivedMessagesCopyWith<$Res> {
  __$ReceivedMessagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_value.copyWith(
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateWithImplCopyWith<$Res>
    implements _$ReceivedMessagesCopyWith<$Res> {
  factory _$$CreateWithImplCopyWith(
          _$CreateWithImpl value, $Res Function(_$CreateWithImpl) then) =
      __$$CreateWithImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Post post});

  @override
  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$$CreateWithImplCopyWithImpl<$Res>
    extends __$ReceivedMessagesCopyWithImpl<$Res, _$CreateWithImpl>
    implements _$$CreateWithImplCopyWith<$Res> {
  __$$CreateWithImplCopyWithImpl(
      _$CreateWithImpl _value, $Res Function(_$CreateWithImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$CreateWithImpl(
      null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$CreateWithImpl with DiagnosticableTreeMixin implements CreateWith {
  const _$CreateWithImpl(this.post);

  @override
  final Post post;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ReceivedMessages.createWith(post: $post)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_ReceivedMessages.createWith'))
      ..add(DiagnosticsProperty('post', post));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateWithImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateWithImplCopyWith<_$CreateWithImpl> get copyWith =>
      __$$CreateWithImplCopyWithImpl<_$CreateWithImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Post post) createWith,
  }) {
    return createWith(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Post post)? createWith,
  }) {
    return createWith?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Post post)? createWith,
    required TResult orElse(),
  }) {
    if (createWith != null) {
      return createWith(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWith value) createWith,
  }) {
    return createWith(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateWith value)? createWith,
  }) {
    return createWith?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWith value)? createWith,
    required TResult orElse(),
  }) {
    if (createWith != null) {
      return createWith(this);
    }
    return orElse();
  }
}

abstract class CreateWith implements _ReceivedMessages {
  const factory CreateWith(final Post post) = _$CreateWithImpl;

  @override
  Post get post;
  @override
  @JsonKey(ignore: true)
  _$$CreateWithImplCopyWith<_$CreateWithImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookmarkItemViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() bookmarked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? bookmarked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? bookmarked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Pending value) pending,
    required TResult Function(Bookmarked value) bookmarked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Pending value)? pending,
    TResult? Function(Bookmarked value)? bookmarked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Pending value)? pending,
    TResult Function(Bookmarked value)? bookmarked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkItemViewStateCopyWith<$Res> {
  factory $BookmarkItemViewStateCopyWith(BookmarkItemViewState value,
          $Res Function(BookmarkItemViewState) then) =
      _$BookmarkItemViewStateCopyWithImpl<$Res, BookmarkItemViewState>;
}

/// @nodoc
class _$BookmarkItemViewStateCopyWithImpl<$Res,
        $Val extends BookmarkItemViewState>
    implements $BookmarkItemViewStateCopyWith<$Res> {
  _$BookmarkItemViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PendingImplCopyWith<$Res> {
  factory _$$PendingImplCopyWith(
          _$PendingImpl value, $Res Function(_$PendingImpl) then) =
      __$$PendingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PendingImplCopyWithImpl<$Res>
    extends _$BookmarkItemViewStateCopyWithImpl<$Res, _$PendingImpl>
    implements _$$PendingImplCopyWith<$Res> {
  __$$PendingImplCopyWithImpl(
      _$PendingImpl _value, $Res Function(_$PendingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PendingImpl with DiagnosticableTreeMixin implements Pending {
  const _$PendingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookmarkItemViewState.pending()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'BookmarkItemViewState.pending'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PendingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() bookmarked,
  }) {
    return pending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? bookmarked,
  }) {
    return pending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? bookmarked,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Pending value) pending,
    required TResult Function(Bookmarked value) bookmarked,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Pending value)? pending,
    TResult? Function(Bookmarked value)? bookmarked,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Pending value)? pending,
    TResult Function(Bookmarked value)? bookmarked,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }
}

abstract class Pending implements BookmarkItemViewState {
  const factory Pending() = _$PendingImpl;
}

/// @nodoc
abstract class _$$BookmarkedImplCopyWith<$Res> {
  factory _$$BookmarkedImplCopyWith(
          _$BookmarkedImpl value, $Res Function(_$BookmarkedImpl) then) =
      __$$BookmarkedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookmarkedImplCopyWithImpl<$Res>
    extends _$BookmarkItemViewStateCopyWithImpl<$Res, _$BookmarkedImpl>
    implements _$$BookmarkedImplCopyWith<$Res> {
  __$$BookmarkedImplCopyWithImpl(
      _$BookmarkedImpl _value, $Res Function(_$BookmarkedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookmarkedImpl with DiagnosticableTreeMixin implements Bookmarked {
  const _$BookmarkedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookmarkItemViewState.bookmarked()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'BookmarkItemViewState.bookmarked'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookmarkedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() bookmarked,
  }) {
    return bookmarked();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? bookmarked,
  }) {
    return bookmarked?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? bookmarked,
    required TResult orElse(),
  }) {
    if (bookmarked != null) {
      return bookmarked();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Pending value) pending,
    required TResult Function(Bookmarked value) bookmarked,
  }) {
    return bookmarked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Pending value)? pending,
    TResult? Function(Bookmarked value)? bookmarked,
  }) {
    return bookmarked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Pending value)? pending,
    TResult Function(Bookmarked value)? bookmarked,
    required TResult orElse(),
  }) {
    if (bookmarked != null) {
      return bookmarked(this);
    }
    return orElse();
  }
}

abstract class Bookmarked implements BookmarkItemViewState {
  const factory Bookmarked() = _$BookmarkedImpl;
}
