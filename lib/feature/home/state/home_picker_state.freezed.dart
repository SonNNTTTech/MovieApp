// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePickerState {
  MovieType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePickerStateCopyWith<HomePickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePickerStateCopyWith<$Res> {
  factory $HomePickerStateCopyWith(
          HomePickerState value, $Res Function(HomePickerState) then) =
      _$HomePickerStateCopyWithImpl<$Res, HomePickerState>;
  @useResult
  $Res call({MovieType type});
}

/// @nodoc
class _$HomePickerStateCopyWithImpl<$Res, $Val extends HomePickerState>
    implements $HomePickerStateCopyWith<$Res> {
  _$HomePickerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MovieType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomePickerStateImplCopyWith<$Res>
    implements $HomePickerStateCopyWith<$Res> {
  factory _$$HomePickerStateImplCopyWith(_$HomePickerStateImpl value,
          $Res Function(_$HomePickerStateImpl) then) =
      __$$HomePickerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MovieType type});
}

/// @nodoc
class __$$HomePickerStateImplCopyWithImpl<$Res>
    extends _$HomePickerStateCopyWithImpl<$Res, _$HomePickerStateImpl>
    implements _$$HomePickerStateImplCopyWith<$Res> {
  __$$HomePickerStateImplCopyWithImpl(
      _$HomePickerStateImpl _value, $Res Function(_$HomePickerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$HomePickerStateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MovieType,
    ));
  }
}

/// @nodoc

class _$HomePickerStateImpl implements _HomePickerState {
  const _$HomePickerStateImpl({required this.type});

  @override
  final MovieType type;

  @override
  String toString() {
    return 'HomePickerState(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePickerStateImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePickerStateImplCopyWith<_$HomePickerStateImpl> get copyWith =>
      __$$HomePickerStateImplCopyWithImpl<_$HomePickerStateImpl>(
          this, _$identity);
}

abstract class _HomePickerState implements HomePickerState {
  const factory _HomePickerState({required final MovieType type}) =
      _$HomePickerStateImpl;

  @override
  MovieType get type;
  @override
  @JsonKey(ignore: true)
  _$$HomePickerStateImplCopyWith<_$HomePickerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
