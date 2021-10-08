// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fading_tile_coordinator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FadingTilePropsTearOff {
  const _$FadingTilePropsTearOff();

  _FadingTileProps call({required AnimationController controller}) {
    return _FadingTileProps(
      controller: controller,
    );
  }

  _FadingTilePropsDelayed delayed(
      {required AnimationController controller, required Interval interval}) {
    return _FadingTilePropsDelayed(
      controller: controller,
      interval: interval,
    );
  }

  _FadingTilePropsInProgress inProgress(
      {required AnimationController controller, required double progress}) {
    return _FadingTilePropsInProgress(
      controller: controller,
      progress: progress,
    );
  }
}

/// @nodoc
const $FadingTileProps = _$FadingTilePropsTearOff();

/// @nodoc
mixin _$FadingTileProps {
  AnimationController get controller => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AnimationController controller) $default, {
    required TResult Function(AnimationController controller, Interval interval)
        delayed,
    required TResult Function(AnimationController controller, double progress)
        inProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FadingTileProps value) $default, {
    required TResult Function(_FadingTilePropsDelayed value) delayed,
    required TResult Function(_FadingTilePropsInProgress value) inProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FadingTilePropsCopyWith<FadingTileProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FadingTilePropsCopyWith<$Res> {
  factory $FadingTilePropsCopyWith(
          FadingTileProps value, $Res Function(FadingTileProps) then) =
      _$FadingTilePropsCopyWithImpl<$Res>;
  $Res call({AnimationController controller});
}

/// @nodoc
class _$FadingTilePropsCopyWithImpl<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  _$FadingTilePropsCopyWithImpl(this._value, this._then);

  final FadingTileProps _value;
  // ignore: unused_field
  final $Res Function(FadingTileProps) _then;

  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as AnimationController,
    ));
  }
}

/// @nodoc
abstract class _$FadingTilePropsCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$FadingTilePropsCopyWith(
          _FadingTileProps value, $Res Function(_FadingTileProps) then) =
      __$FadingTilePropsCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller});
}

/// @nodoc
class __$FadingTilePropsCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$FadingTilePropsCopyWith<$Res> {
  __$FadingTilePropsCopyWithImpl(
      _FadingTileProps _value, $Res Function(_FadingTileProps) _then)
      : super(_value, (v) => _then(v as _FadingTileProps));

  @override
  _FadingTileProps get _value => super._value as _FadingTileProps;

  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_FadingTileProps(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as AnimationController,
    ));
  }
}

/// @nodoc

class _$_FadingTileProps implements _FadingTileProps {
  const _$_FadingTileProps({required this.controller});

  @override
  final AnimationController controller;

  @override
  String toString() {
    return 'FadingTileProps(controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FadingTileProps &&
            (identical(other.controller, controller) ||
                const DeepCollectionEquality()
                    .equals(other.controller, controller)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(controller);

  @JsonKey(ignore: true)
  @override
  _$FadingTilePropsCopyWith<_FadingTileProps> get copyWith =>
      __$FadingTilePropsCopyWithImpl<_FadingTileProps>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AnimationController controller) $default, {
    required TResult Function(AnimationController controller, Interval interval)
        delayed,
    required TResult Function(AnimationController controller, double progress)
        inProgress,
  }) {
    return $default(controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
  }) {
    return $default?.call(controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FadingTileProps value) $default, {
    required TResult Function(_FadingTilePropsDelayed value) delayed,
    required TResult Function(_FadingTilePropsInProgress value) inProgress,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _FadingTileProps implements FadingTileProps {
  const factory _FadingTileProps({required AnimationController controller}) =
      _$_FadingTileProps;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FadingTilePropsCopyWith<_FadingTileProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FadingTilePropsDelayedCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$FadingTilePropsDelayedCopyWith(_FadingTilePropsDelayed value,
          $Res Function(_FadingTilePropsDelayed) then) =
      __$FadingTilePropsDelayedCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller, Interval interval});
}

/// @nodoc
class __$FadingTilePropsDelayedCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$FadingTilePropsDelayedCopyWith<$Res> {
  __$FadingTilePropsDelayedCopyWithImpl(_FadingTilePropsDelayed _value,
      $Res Function(_FadingTilePropsDelayed) _then)
      : super(_value, (v) => _then(v as _FadingTilePropsDelayed));

  @override
  _FadingTilePropsDelayed get _value => super._value as _FadingTilePropsDelayed;

  @override
  $Res call({
    Object? controller = freezed,
    Object? interval = freezed,
  }) {
    return _then(_FadingTilePropsDelayed(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as AnimationController,
      interval: interval == freezed
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Interval,
    ));
  }
}

/// @nodoc

class _$_FadingTilePropsDelayed implements _FadingTilePropsDelayed {
  const _$_FadingTilePropsDelayed(
      {required this.controller, required this.interval});

  @override
  final AnimationController controller;
  @override
  final Interval interval;

  @override
  String toString() {
    return 'FadingTileProps.delayed(controller: $controller, interval: $interval)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FadingTilePropsDelayed &&
            (identical(other.controller, controller) ||
                const DeepCollectionEquality()
                    .equals(other.controller, controller)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(controller) ^
      const DeepCollectionEquality().hash(interval);

  @JsonKey(ignore: true)
  @override
  _$FadingTilePropsDelayedCopyWith<_FadingTilePropsDelayed> get copyWith =>
      __$FadingTilePropsDelayedCopyWithImpl<_FadingTilePropsDelayed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AnimationController controller) $default, {
    required TResult Function(AnimationController controller, Interval interval)
        delayed,
    required TResult Function(AnimationController controller, double progress)
        inProgress,
  }) {
    return delayed(controller, interval);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
  }) {
    return delayed?.call(controller, interval);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
    required TResult orElse(),
  }) {
    if (delayed != null) {
      return delayed(controller, interval);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FadingTileProps value) $default, {
    required TResult Function(_FadingTilePropsDelayed value) delayed,
    required TResult Function(_FadingTilePropsInProgress value) inProgress,
  }) {
    return delayed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
  }) {
    return delayed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
    required TResult orElse(),
  }) {
    if (delayed != null) {
      return delayed(this);
    }
    return orElse();
  }
}

abstract class _FadingTilePropsDelayed implements FadingTileProps {
  const factory _FadingTilePropsDelayed(
      {required AnimationController controller,
      required Interval interval}) = _$_FadingTilePropsDelayed;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  Interval get interval => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FadingTilePropsDelayedCopyWith<_FadingTilePropsDelayed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FadingTilePropsInProgressCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$FadingTilePropsInProgressCopyWith(_FadingTilePropsInProgress value,
          $Res Function(_FadingTilePropsInProgress) then) =
      __$FadingTilePropsInProgressCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller, double progress});
}

/// @nodoc
class __$FadingTilePropsInProgressCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$FadingTilePropsInProgressCopyWith<$Res> {
  __$FadingTilePropsInProgressCopyWithImpl(_FadingTilePropsInProgress _value,
      $Res Function(_FadingTilePropsInProgress) _then)
      : super(_value, (v) => _then(v as _FadingTilePropsInProgress));

  @override
  _FadingTilePropsInProgress get _value =>
      super._value as _FadingTilePropsInProgress;

  @override
  $Res call({
    Object? controller = freezed,
    Object? progress = freezed,
  }) {
    return _then(_FadingTilePropsInProgress(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as AnimationController,
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_FadingTilePropsInProgress implements _FadingTilePropsInProgress {
  const _$_FadingTilePropsInProgress(
      {required this.controller, required this.progress});

  @override
  final AnimationController controller;
  @override
  final double progress;

  @override
  String toString() {
    return 'FadingTileProps.inProgress(controller: $controller, progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FadingTilePropsInProgress &&
            (identical(other.controller, controller) ||
                const DeepCollectionEquality()
                    .equals(other.controller, controller)) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality()
                    .equals(other.progress, progress)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(controller) ^
      const DeepCollectionEquality().hash(progress);

  @JsonKey(ignore: true)
  @override
  _$FadingTilePropsInProgressCopyWith<_FadingTilePropsInProgress>
      get copyWith =>
          __$FadingTilePropsInProgressCopyWithImpl<_FadingTilePropsInProgress>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(AnimationController controller) $default, {
    required TResult Function(AnimationController controller, Interval interval)
        delayed,
    required TResult Function(AnimationController controller, double progress)
        inProgress,
  }) {
    return inProgress(controller, progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
  }) {
    return inProgress?.call(controller, progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(AnimationController controller)? $default, {
    TResult Function(AnimationController controller, Interval interval)?
        delayed,
    TResult Function(AnimationController controller, double progress)?
        inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(controller, progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FadingTileProps value) $default, {
    required TResult Function(_FadingTilePropsDelayed value) delayed,
    required TResult Function(_FadingTilePropsInProgress value) inProgress,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FadingTileProps value)? $default, {
    TResult Function(_FadingTilePropsDelayed value)? delayed,
    TResult Function(_FadingTilePropsInProgress value)? inProgress,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _FadingTilePropsInProgress implements FadingTileProps {
  const factory _FadingTilePropsInProgress(
      {required AnimationController controller,
      required double progress}) = _$_FadingTilePropsInProgress;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FadingTilePropsInProgressCopyWith<_FadingTilePropsInProgress>
      get copyWith => throw _privateConstructorUsedError;
}
