// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoviePageState {
  List<MovieEntity> get movies => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isNoMorePage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isNewPageLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoviePageStateCopyWith<MoviePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviePageStateCopyWith<$Res> {
  factory $MoviePageStateCopyWith(
          MoviePageState value, $Res Function(MoviePageState) then) =
      _$MoviePageStateCopyWithImpl<$Res, MoviePageState>;
  @useResult
  $Res call(
      {List<MovieEntity> movies,
      String? error,
      bool isNoMorePage,
      bool isLoading,
      bool isNewPageLoading});
}

/// @nodoc
class _$MoviePageStateCopyWithImpl<$Res, $Val extends MoviePageState>
    implements $MoviePageStateCopyWith<$Res> {
  _$MoviePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
    Object? error = freezed,
    Object? isNoMorePage = null,
    Object? isLoading = null,
    Object? isNewPageLoading = null,
  }) {
    return _then(_value.copyWith(
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<MovieEntity>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isNoMorePage: null == isNoMorePage
          ? _value.isNoMorePage
          : isNoMorePage // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewPageLoading: null == isNewPageLoading
          ? _value.isNewPageLoading
          : isNewPageLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoviePageStateImplCopyWith<$Res>
    implements $MoviePageStateCopyWith<$Res> {
  factory _$$MoviePageStateImplCopyWith(_$MoviePageStateImpl value,
          $Res Function(_$MoviePageStateImpl) then) =
      __$$MoviePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MovieEntity> movies,
      String? error,
      bool isNoMorePage,
      bool isLoading,
      bool isNewPageLoading});
}

/// @nodoc
class __$$MoviePageStateImplCopyWithImpl<$Res>
    extends _$MoviePageStateCopyWithImpl<$Res, _$MoviePageStateImpl>
    implements _$$MoviePageStateImplCopyWith<$Res> {
  __$$MoviePageStateImplCopyWithImpl(
      _$MoviePageStateImpl _value, $Res Function(_$MoviePageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movies = null,
    Object? error = freezed,
    Object? isNoMorePage = null,
    Object? isLoading = null,
    Object? isNewPageLoading = null,
  }) {
    return _then(_$MoviePageStateImpl(
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<MovieEntity>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isNoMorePage: null == isNoMorePage
          ? _value.isNoMorePage
          : isNoMorePage // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewPageLoading: null == isNewPageLoading
          ? _value.isNewPageLoading
          : isNewPageLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MoviePageStateImpl implements _MoviePageState {
  const _$MoviePageStateImpl(
      {required this.movies,
      this.error,
      this.isNoMorePage = false,
      this.isLoading = true,
      this.isNewPageLoading = false});

  @override
  final List<MovieEntity> movies;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isNoMorePage;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isNewPageLoading;

  @override
  String toString() {
    return 'MoviePageState(movies: $movies, error: $error, isNoMorePage: $isNoMorePage, isLoading: $isLoading, isNewPageLoading: $isNewPageLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviePageStateImpl &&
            const DeepCollectionEquality().equals(other.movies, movies) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isNoMorePage, isNoMorePage) ||
                other.isNoMorePage == isNoMorePage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isNewPageLoading, isNewPageLoading) ||
                other.isNewPageLoading == isNewPageLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(movies),
      error,
      isNoMorePage,
      isLoading,
      isNewPageLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviePageStateImplCopyWith<_$MoviePageStateImpl> get copyWith =>
      __$$MoviePageStateImplCopyWithImpl<_$MoviePageStateImpl>(
          this, _$identity);
}

abstract class _MoviePageState implements MoviePageState {
  const factory _MoviePageState(
      {required final List<MovieEntity> movies,
      final String? error,
      final bool isNoMorePage,
      final bool isLoading,
      final bool isNewPageLoading}) = _$MoviePageStateImpl;

  @override
  List<MovieEntity> get movies;
  @override
  String? get error;
  @override
  bool get isNoMorePage;
  @override
  bool get isLoading;
  @override
  bool get isNewPageLoading;
  @override
  @JsonKey(ignore: true)
  _$$MoviePageStateImplCopyWith<_$MoviePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
