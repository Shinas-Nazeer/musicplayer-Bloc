// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'screen_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScreenHomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initailize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initailize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initailize,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initailize value) initailize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initailize value)? initailize,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initailize value)? initailize,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenHomeEventCopyWith<$Res> {
  factory $ScreenHomeEventCopyWith(
          ScreenHomeEvent value, $Res Function(ScreenHomeEvent) then) =
      _$ScreenHomeEventCopyWithImpl<$Res, ScreenHomeEvent>;
}

/// @nodoc
class _$ScreenHomeEventCopyWithImpl<$Res, $Val extends ScreenHomeEvent>
    implements $ScreenHomeEventCopyWith<$Res> {
  _$ScreenHomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitailizeCopyWith<$Res> {
  factory _$$InitailizeCopyWith(
          _$Initailize value, $Res Function(_$Initailize) then) =
      __$$InitailizeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitailizeCopyWithImpl<$Res>
    extends _$ScreenHomeEventCopyWithImpl<$Res, _$Initailize>
    implements _$$InitailizeCopyWith<$Res> {
  __$$InitailizeCopyWithImpl(
      _$Initailize _value, $Res Function(_$Initailize) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Initailize implements Initailize {
  const _$Initailize();

  @override
  String toString() {
    return 'ScreenHomeEvent.initailize()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initailize);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initailize,
  }) {
    return initailize();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initailize,
  }) {
    return initailize?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initailize,
    required TResult orElse(),
  }) {
    if (initailize != null) {
      return initailize();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initailize value) initailize,
  }) {
    return initailize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initailize value)? initailize,
  }) {
    return initailize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initailize value)? initailize,
    required TResult orElse(),
  }) {
    if (initailize != null) {
      return initailize(this);
    }
    return orElse();
  }
}

abstract class Initailize implements ScreenHomeEvent {
  const factory Initailize() = _$Initailize;
}

/// @nodoc
mixin _$ScreenHomeState {
  List<Songs> get songList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScreenHomeStateCopyWith<ScreenHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenHomeStateCopyWith<$Res> {
  factory $ScreenHomeStateCopyWith(
          ScreenHomeState value, $Res Function(ScreenHomeState) then) =
      _$ScreenHomeStateCopyWithImpl<$Res, ScreenHomeState>;
  @useResult
  $Res call({List<Songs> songList});
}

/// @nodoc
class _$ScreenHomeStateCopyWithImpl<$Res, $Val extends ScreenHomeState>
    implements $ScreenHomeStateCopyWith<$Res> {
  _$ScreenHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songList = null,
  }) {
    return _then(_value.copyWith(
      songList: null == songList
          ? _value.songList
          : songList // ignore: cast_nullable_to_non_nullable
              as List<Songs>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScreenHomeStateCopyWith<$Res>
    implements $ScreenHomeStateCopyWith<$Res> {
  factory _$$_ScreenHomeStateCopyWith(
          _$_ScreenHomeState value, $Res Function(_$_ScreenHomeState) then) =
      __$$_ScreenHomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Songs> songList});
}

/// @nodoc
class __$$_ScreenHomeStateCopyWithImpl<$Res>
    extends _$ScreenHomeStateCopyWithImpl<$Res, _$_ScreenHomeState>
    implements _$$_ScreenHomeStateCopyWith<$Res> {
  __$$_ScreenHomeStateCopyWithImpl(
      _$_ScreenHomeState _value, $Res Function(_$_ScreenHomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songList = null,
  }) {
    return _then(_$_ScreenHomeState(
      songList: null == songList
          ? _value._songList
          : songList // ignore: cast_nullable_to_non_nullable
              as List<Songs>,
    ));
  }
}

/// @nodoc

class _$_ScreenHomeState implements _ScreenHomeState {
  const _$_ScreenHomeState({required final List<Songs> songList})
      : _songList = songList;

  final List<Songs> _songList;
  @override
  List<Songs> get songList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songList);
  }

  @override
  String toString() {
    return 'ScreenHomeState(songList: $songList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScreenHomeState &&
            const DeepCollectionEquality().equals(other._songList, _songList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_songList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScreenHomeStateCopyWith<_$_ScreenHomeState> get copyWith =>
      __$$_ScreenHomeStateCopyWithImpl<_$_ScreenHomeState>(this, _$identity);
}

abstract class _ScreenHomeState implements ScreenHomeState {
  const factory _ScreenHomeState({required final List<Songs> songList}) =
      _$_ScreenHomeState;

  @override
  List<Songs> get songList;
  @override
  @JsonKey(ignore: true)
  _$$_ScreenHomeStateCopyWith<_$_ScreenHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
