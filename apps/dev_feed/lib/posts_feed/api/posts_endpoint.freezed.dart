// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_endpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostsEndpoint {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) get,
    required TResult Function(int id) getOne,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? get,
    TResult? Function(int id)? getOne,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? get,
    TResult Function(int id)? getOne,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Get value) get,
    required TResult Function(GetOne value) getOne,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Get value)? get,
    TResult? Function(GetOne value)? getOne,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Get value)? get,
    TResult Function(GetOne value)? getOne,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsEndpointCopyWith<$Res> {
  factory $PostsEndpointCopyWith(
          PostsEndpoint value, $Res Function(PostsEndpoint) then) =
      _$PostsEndpointCopyWithImpl<$Res, PostsEndpoint>;
}

/// @nodoc
class _$PostsEndpointCopyWithImpl<$Res, $Val extends PostsEndpoint>
    implements $PostsEndpointCopyWith<$Res> {
  _$PostsEndpointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetImplCopyWith<$Res> {
  factory _$$GetImplCopyWith(_$GetImpl value, $Res Function(_$GetImpl) then) =
      __$$GetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int page});
}

/// @nodoc
class __$$GetImplCopyWithImpl<$Res>
    extends _$PostsEndpointCopyWithImpl<$Res, _$GetImpl>
    implements _$$GetImplCopyWith<$Res> {
  __$$GetImplCopyWithImpl(_$GetImpl _value, $Res Function(_$GetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$GetImpl(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetImpl extends Get {
  const _$GetImpl(this.page) : super._();

  @override
  final int page;

  @override
  String toString() {
    return 'PostsEndpoint.get(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetImplCopyWith<_$GetImpl> get copyWith =>
      __$$GetImplCopyWithImpl<_$GetImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) get,
    required TResult Function(int id) getOne,
  }) {
    return get(page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? get,
    TResult? Function(int id)? getOne,
  }) {
    return get?.call(page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? get,
    TResult Function(int id)? getOne,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get(page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Get value) get,
    required TResult Function(GetOne value) getOne,
  }) {
    return get(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Get value)? get,
    TResult? Function(GetOne value)? getOne,
  }) {
    return get?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Get value)? get,
    TResult Function(GetOne value)? getOne,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get(this);
    }
    return orElse();
  }
}

abstract class Get extends PostsEndpoint {
  const factory Get(final int page) = _$GetImpl;
  const Get._() : super._();

  int get page;
  @JsonKey(ignore: true)
  _$$GetImplCopyWith<_$GetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetOneImplCopyWith<$Res> {
  factory _$$GetOneImplCopyWith(
          _$GetOneImpl value, $Res Function(_$GetOneImpl) then) =
      __$$GetOneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$GetOneImplCopyWithImpl<$Res>
    extends _$PostsEndpointCopyWithImpl<$Res, _$GetOneImpl>
    implements _$$GetOneImplCopyWith<$Res> {
  __$$GetOneImplCopyWithImpl(
      _$GetOneImpl _value, $Res Function(_$GetOneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$GetOneImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetOneImpl extends GetOne {
  const _$GetOneImpl(this.id) : super._();

  @override
  final int id;

  @override
  String toString() {
    return 'PostsEndpoint.getOne(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOneImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOneImplCopyWith<_$GetOneImpl> get copyWith =>
      __$$GetOneImplCopyWithImpl<_$GetOneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int page) get,
    required TResult Function(int id) getOne,
  }) {
    return getOne(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int page)? get,
    TResult? Function(int id)? getOne,
  }) {
    return getOne?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int page)? get,
    TResult Function(int id)? getOne,
    required TResult orElse(),
  }) {
    if (getOne != null) {
      return getOne(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Get value) get,
    required TResult Function(GetOne value) getOne,
  }) {
    return getOne(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Get value)? get,
    TResult? Function(GetOne value)? getOne,
  }) {
    return getOne?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Get value)? get,
    TResult Function(GetOne value)? getOne,
    required TResult orElse(),
  }) {
    if (getOne != null) {
      return getOne(this);
    }
    return orElse();
  }
}

abstract class GetOne extends PostsEndpoint {
  const factory GetOne(final int id) = _$GetOneImpl;
  const GetOne._() : super._();

  int get id;
  @JsonKey(ignore: true)
  _$$GetOneImplCopyWith<_$GetOneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
