// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fading_tile_coordinator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_FadingTilePropsCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$$_FadingTilePropsCopyWith(
          _$_FadingTileProps value, $Res Function(_$_FadingTileProps) then) =
      __$$_FadingTilePropsCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller});
}

/// @nodoc
class __$$_FadingTilePropsCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$$_FadingTilePropsCopyWith<$Res> {
  __$$_FadingTilePropsCopyWithImpl(
      _$_FadingTileProps _value, $Res Function(_$_FadingTileProps) _then)
      : super(_value, (v) => _then(v as _$_FadingTileProps));

  @override
  _$_FadingTileProps get _value => super._value as _$_FadingTileProps;

  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_$_FadingTileProps(
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as AnimationController,
    ));
  }
}

/// @nodoc

class _$_FadingTileProps
    with DiagnosticableTreeMixin
    implements _FadingTileProps {
  const _$_FadingTileProps({required this.controller});

  @override
  final AnimationController controller;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FadingTileProps(controller: $controller)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FadingTileProps'))
      ..add(DiagnosticsProperty('controller', controller));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FadingTileProps &&
            const DeepCollectionEquality()
                .equals(other.controller, controller));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(controller));

  @JsonKey(ignore: true)
  @override
  _$$_FadingTilePropsCopyWith<_$_FadingTileProps> get copyWith =>
      __$$_FadingTilePropsCopyWithImpl<_$_FadingTileProps>(this, _$identity);

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
  const factory _FadingTileProps(
      {required final AnimationController controller}) = _$_FadingTileProps;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FadingTilePropsCopyWith<_$_FadingTileProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FadingTilePropsDelayedCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$$_FadingTilePropsDelayedCopyWith(_$_FadingTilePropsDelayed value,
          $Res Function(_$_FadingTilePropsDelayed) then) =
      __$$_FadingTilePropsDelayedCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller, Interval interval});
}

/// @nodoc
class __$$_FadingTilePropsDelayedCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$$_FadingTilePropsDelayedCopyWith<$Res> {
  __$$_FadingTilePropsDelayedCopyWithImpl(_$_FadingTilePropsDelayed _value,
      $Res Function(_$_FadingTilePropsDelayed) _then)
      : super(_value, (v) => _then(v as _$_FadingTilePropsDelayed));

  @override
  _$_FadingTilePropsDelayed get _value =>
      super._value as _$_FadingTilePropsDelayed;

  @override
  $Res call({
    Object? controller = freezed,
    Object? interval = freezed,
  }) {
    return _then(_$_FadingTilePropsDelayed(
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

class _$_FadingTilePropsDelayed
    with DiagnosticableTreeMixin
    implements _FadingTilePropsDelayed {
  const _$_FadingTilePropsDelayed(
      {required this.controller, required this.interval});

  @override
  final AnimationController controller;
  @override
  final Interval interval;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FadingTileProps.delayed(controller: $controller, interval: $interval)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FadingTileProps.delayed'))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('interval', interval));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FadingTilePropsDelayed &&
            const DeepCollectionEquality()
                .equals(other.controller, controller) &&
            const DeepCollectionEquality().equals(other.interval, interval));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(controller),
      const DeepCollectionEquality().hash(interval));

  @JsonKey(ignore: true)
  @override
  _$$_FadingTilePropsDelayedCopyWith<_$_FadingTilePropsDelayed> get copyWith =>
      __$$_FadingTilePropsDelayedCopyWithImpl<_$_FadingTilePropsDelayed>(
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
      {required final AnimationController controller,
      required final Interval interval}) = _$_FadingTilePropsDelayed;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  Interval get interval => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FadingTilePropsDelayedCopyWith<_$_FadingTilePropsDelayed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_FadingTilePropsInProgressCopyWith<$Res>
    implements $FadingTilePropsCopyWith<$Res> {
  factory _$$_FadingTilePropsInProgressCopyWith(
          _$_FadingTilePropsInProgress value,
          $Res Function(_$_FadingTilePropsInProgress) then) =
      __$$_FadingTilePropsInProgressCopyWithImpl<$Res>;
  @override
  $Res call({AnimationController controller, double progress});
}

/// @nodoc
class __$$_FadingTilePropsInProgressCopyWithImpl<$Res>
    extends _$FadingTilePropsCopyWithImpl<$Res>
    implements _$$_FadingTilePropsInProgressCopyWith<$Res> {
  __$$_FadingTilePropsInProgressCopyWithImpl(
      _$_FadingTilePropsInProgress _value,
      $Res Function(_$_FadingTilePropsInProgress) _then)
      : super(_value, (v) => _then(v as _$_FadingTilePropsInProgress));

  @override
  _$_FadingTilePropsInProgress get _value =>
      super._value as _$_FadingTilePropsInProgress;

  @override
  $Res call({
    Object? controller = freezed,
    Object? progress = freezed,
  }) {
    return _then(_$_FadingTilePropsInProgress(
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

class _$_FadingTilePropsInProgress
    with DiagnosticableTreeMixin
    implements _FadingTilePropsInProgress {
  const _$_FadingTilePropsInProgress(
      {required this.controller, required this.progress});

  @override
  final AnimationController controller;
  @override
  final double progress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FadingTileProps.inProgress(controller: $controller, progress: $progress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FadingTileProps.inProgress'))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('progress', progress));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FadingTilePropsInProgress &&
            const DeepCollectionEquality()
                .equals(other.controller, controller) &&
            const DeepCollectionEquality().equals(other.progress, progress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(controller),
      const DeepCollectionEquality().hash(progress));

  @JsonKey(ignore: true)
  @override
  _$$_FadingTilePropsInProgressCopyWith<_$_FadingTilePropsInProgress>
      get copyWith => __$$_FadingTilePropsInProgressCopyWithImpl<
          _$_FadingTilePropsInProgress>(this, _$identity);

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
      {required final AnimationController controller,
      required final double progress}) = _$_FadingTilePropsInProgress;

  @override
  AnimationController get controller => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FadingTilePropsInProgressCopyWith<_$_FadingTilePropsInProgress>
      get copyWith => throw _privateConstructorUsedError;
}
