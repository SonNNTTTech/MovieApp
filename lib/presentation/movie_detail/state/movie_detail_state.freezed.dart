// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MovieDetailState {
  MovieDetailEntity? get entity => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool? get isLoading => throw _privateConstructorUsedError;
  bool get isFavorited => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MovieDetailStateCopyWith<MovieDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDetailStateCopyWith<$Res> {
  factory $MovieDetailStateCopyWith(
          MovieDetailState value, $Res Function(MovieDetailState) then) =
      _$MovieDetailStateCopyWithImpl<$Res, MovieDetailState>;
  @useResult
  $Res call(
      {MovieDetailEntity? entity,
      List<String>? images,
      String? error,
      bool? isLoading,
      bool isFavorited});
}

/// @nodoc
class _$MovieDetailStateCopyWithImpl<$Res, $Val extends MovieDetailState>
    implements $MovieDetailStateCopyWith<$Res> {
  _$MovieDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entity = freezed,
    Object? images = freezed,
    Object? error = freezed,
    Object? isLoading = freezed,
    Object? isFavorited = null,
  }) {
    return _then(_value.copyWith(
      entity: freezed == entity
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as MovieDetailEntity?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieDetailStateImplCopyWith<$Res>
    implements $MovieDetailStateCopyWith<$Res> {
  factory _$$MovieDetailStateImplCopyWith(_$MovieDetailStateImpl value,
          $Res Function(_$MovieDetailStateImpl) then) =
      __$$MovieDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MovieDetailEntity? entity,
      List<String>? images,
      String? error,
      bool? isLoading,
      bool isFavorited});
}

/// @nodoc
class __$$MovieDetailStateImplCopyWithImpl<$Res>
    extends _$MovieDetailStateCopyWithImpl<$Res, _$MovieDetailStateImpl>
    implements _$$MovieDetailStateImplCopyWith<$Res> {
  __$$MovieDetailStateImplCopyWithImpl(_$MovieDetailStateImpl _value,
      $Res Function(_$MovieDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entity = freezed,
    Object? images = freezed,
    Object? error = freezed,
    Object? isLoading = freezed,
    Object? isFavorited = null,
  }) {
    return _then(_$MovieDetailStateImpl(
      entity: freezed == entity
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as MovieDetailEntity?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MovieDetailStateImpl implements _MovieDetailState {
  const _$MovieDetailStateImpl(
      {this.entity,
      final List<String>? images,
      this.error,
      this.isLoading,
      required this.isFavorited})
      : _images = images;

  @override
  final MovieDetailEntity? entity;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;
  @override
  final bool? isLoading;
  @override
  final bool isFavorited;

  @override
  String toString() {
    return 'MovieDetailState(entity: $entity, images: $images, error: $error, isLoading: $isLoading, isFavorited: $isFavorited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieDetailStateImpl &&
            (identical(other.entity, entity) || other.entity == entity) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isFavorited, isFavorited) ||
                other.isFavorited == isFavorited));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      entity,
      const DeepCollectionEquality().hash(_images),
      error,
      isLoading,
      isFavorited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieDetailStateImplCopyWith<_$MovieDetailStateImpl> get copyWith =>
      __$$MovieDetailStateImplCopyWithImpl<_$MovieDetailStateImpl>(
          this, _$identity);
}

abstract class _MovieDetailState implements MovieDetailState {
  const factory _MovieDetailState(
      {final MovieDetailEntity? entity,
      final List<String>? images,
      final String? error,
      final bool? isLoading,
      required final bool isFavorited}) = _$MovieDetailStateImpl;

  @override
  MovieDetailEntity? get entity;
  @override
  List<String>? get images;
  @override
  String? get error;
  @override
  bool? get isLoading;
  @override
  bool get isFavorited;
  @override
  @JsonKey(ignore: true)
  _$$MovieDetailStateImplCopyWith<_$MovieDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
