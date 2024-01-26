// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$APIResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(APISuccess<T> value) success,
    required TResult Function(APIError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(APISuccess<T> value)? success,
    TResult? Function(APIError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(APISuccess<T> value)? success,
    TResult Function(APIError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIResponseCopyWith<T, $Res> {
  factory $APIResponseCopyWith(
          APIResponse<T> value, $Res Function(APIResponse<T>) then) =
      _$APIResponseCopyWithImpl<T, $Res, APIResponse<T>>;
}

/// @nodoc
class _$APIResponseCopyWithImpl<T, $Res, $Val extends APIResponse<T>>
    implements $APIResponseCopyWith<T, $Res> {
  _$APIResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$APISuccessImplCopyWith<T, $Res> {
  factory _$$APISuccessImplCopyWith(
          _$APISuccessImpl<T> value, $Res Function(_$APISuccessImpl<T>) then) =
      __$$APISuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$APISuccessImplCopyWithImpl<T, $Res>
    extends _$APIResponseCopyWithImpl<T, $Res, _$APISuccessImpl<T>>
    implements _$$APISuccessImplCopyWith<T, $Res> {
  __$$APISuccessImplCopyWithImpl(
      _$APISuccessImpl<T> _value, $Res Function(_$APISuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$APISuccessImpl<T>(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$APISuccessImpl<T> implements APISuccess<T> {
  const _$APISuccessImpl(this.value);

  @override
  final T value;

  @override
  String toString() {
    return 'APIResponse<$T>.success(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APISuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$APISuccessImplCopyWith<T, _$APISuccessImpl<T>> get copyWith =>
      __$$APISuccessImplCopyWithImpl<T, _$APISuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(String error) error,
  }) {
    return success(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(String error)? error,
  }) {
    return success?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(APISuccess<T> value) success,
    required TResult Function(APIError<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(APISuccess<T> value)? success,
    TResult? Function(APIError<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(APISuccess<T> value)? success,
    TResult Function(APIError<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class APISuccess<T> implements APIResponse<T> {
  const factory APISuccess(final T value) = _$APISuccessImpl<T>;

  T get value;
  @JsonKey(ignore: true)
  _$$APISuccessImplCopyWith<T, _$APISuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$APIErrorImplCopyWith<T, $Res> {
  factory _$$APIErrorImplCopyWith(
          _$APIErrorImpl<T> value, $Res Function(_$APIErrorImpl<T>) then) =
      __$$APIErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$APIErrorImplCopyWithImpl<T, $Res>
    extends _$APIResponseCopyWithImpl<T, $Res, _$APIErrorImpl<T>>
    implements _$$APIErrorImplCopyWith<T, $Res> {
  __$$APIErrorImplCopyWithImpl(
      _$APIErrorImpl<T> _value, $Res Function(_$APIErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$APIErrorImpl<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$APIErrorImpl<T> implements APIError<T> {
  const _$APIErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'APIResponse<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APIErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$APIErrorImplCopyWith<T, _$APIErrorImpl<T>> get copyWith =>
      __$$APIErrorImplCopyWithImpl<T, _$APIErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value) success,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value)? success,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(APISuccess<T> value) success,
    required TResult Function(APIError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(APISuccess<T> value)? success,
    TResult? Function(APIError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(APISuccess<T> value)? success,
    TResult Function(APIError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class APIError<T> implements APIResponse<T> {
  const factory APIError(final String error) = _$APIErrorImpl<T>;

  String get error;
  @JsonKey(ignore: true)
  _$$APIErrorImplCopyWith<T, _$APIErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
