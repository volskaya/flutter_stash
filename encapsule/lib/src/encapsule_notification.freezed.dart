// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'encapsule_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EncapsuleNotificationProps {
  /// Callable to dismiss the notification.
  VoidCallback get dismiss => throw _privateConstructorUsedError;

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  Animation<double>? get dismissAnimation => throw _privateConstructorUsedError;

  /// Reference to the [EncapsuleNotification] these props belong to.
  EncapsuleNotification get reference => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsuleNotificationPropsCopyWith<EncapsuleNotificationProps>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsuleNotificationPropsCopyWith<$Res> {
  factory $EncapsuleNotificationPropsCopyWith(EncapsuleNotificationProps value,
          $Res Function(EncapsuleNotificationProps) then) =
      _$EncapsuleNotificationPropsCopyWithImpl<$Res>;
  $Res call(
      {VoidCallback dismiss,
      Animation<double>? dismissAnimation,
      EncapsuleNotification reference});

  $EncapsuleNotificationCopyWith<$Res> get reference;
}

/// @nodoc
class _$EncapsuleNotificationPropsCopyWithImpl<$Res>
    implements $EncapsuleNotificationPropsCopyWith<$Res> {
  _$EncapsuleNotificationPropsCopyWithImpl(this._value, this._then);

  final EncapsuleNotificationProps _value;
  // ignore: unused_field
  final $Res Function(EncapsuleNotificationProps) _then;

  @override
  $Res call({
    Object? dismiss = freezed,
    Object? dismissAnimation = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      dismiss: dismiss == freezed
          ? _value.dismiss
          : dismiss // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
      dismissAnimation: dismissAnimation == freezed
          ? _value.dismissAnimation
          : dismissAnimation // ignore: cast_nullable_to_non_nullable
              as Animation<double>?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotification,
    ));
  }

  @override
  $EncapsuleNotificationCopyWith<$Res> get reference {
    return $EncapsuleNotificationCopyWith<$Res>(_value.reference, (value) {
      return _then(_value.copyWith(reference: value));
    });
  }
}

/// @nodoc
abstract class _$$_EncapsuleNotificationPropsCopyWith<$Res>
    implements $EncapsuleNotificationPropsCopyWith<$Res> {
  factory _$$_EncapsuleNotificationPropsCopyWith(
          _$_EncapsuleNotificationProps value,
          $Res Function(_$_EncapsuleNotificationProps) then) =
      __$$_EncapsuleNotificationPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {VoidCallback dismiss,
      Animation<double>? dismissAnimation,
      EncapsuleNotification reference});

  @override
  $EncapsuleNotificationCopyWith<$Res> get reference;
}

/// @nodoc
class __$$_EncapsuleNotificationPropsCopyWithImpl<$Res>
    extends _$EncapsuleNotificationPropsCopyWithImpl<$Res>
    implements _$$_EncapsuleNotificationPropsCopyWith<$Res> {
  __$$_EncapsuleNotificationPropsCopyWithImpl(
      _$_EncapsuleNotificationProps _value,
      $Res Function(_$_EncapsuleNotificationProps) _then)
      : super(_value, (v) => _then(v as _$_EncapsuleNotificationProps));

  @override
  _$_EncapsuleNotificationProps get _value =>
      super._value as _$_EncapsuleNotificationProps;

  @override
  $Res call({
    Object? dismiss = freezed,
    Object? dismissAnimation = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$_EncapsuleNotificationProps(
      dismiss: dismiss == freezed
          ? _value.dismiss
          : dismiss // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
      dismissAnimation: dismissAnimation == freezed
          ? _value.dismissAnimation
          : dismissAnimation // ignore: cast_nullable_to_non_nullable
              as Animation<double>?,
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotification,
    ));
  }
}

/// @nodoc

class _$_EncapsuleNotificationProps implements _EncapsuleNotificationProps {
  const _$_EncapsuleNotificationProps(
      {required this.dismiss, this.dismissAnimation, required this.reference});

  /// Callable to dismiss the notification.
  @override
  final VoidCallback dismiss;

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  @override
  final Animation<double>? dismissAnimation;

  /// Reference to the [EncapsuleNotification] these props belong to.
  @override
  final EncapsuleNotification reference;

  @override
  String toString() {
    return 'EncapsuleNotificationProps(dismiss: $dismiss, dismissAnimation: $dismissAnimation, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncapsuleNotificationProps &&
            (identical(other.dismiss, dismiss) || other.dismiss == dismiss) &&
            const DeepCollectionEquality()
                .equals(other.dismissAnimation, dismissAnimation) &&
            const DeepCollectionEquality().equals(other.reference, reference));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dismiss,
      const DeepCollectionEquality().hash(dismissAnimation),
      const DeepCollectionEquality().hash(reference));

  @JsonKey(ignore: true)
  @override
  _$$_EncapsuleNotificationPropsCopyWith<_$_EncapsuleNotificationProps>
      get copyWith => __$$_EncapsuleNotificationPropsCopyWithImpl<
          _$_EncapsuleNotificationProps>(this, _$identity);
}

abstract class _EncapsuleNotificationProps
    implements EncapsuleNotificationProps {
  const factory _EncapsuleNotificationProps(
          {required final VoidCallback dismiss,
          final Animation<double>? dismissAnimation,
          required final EncapsuleNotification reference}) =
      _$_EncapsuleNotificationProps;

  @override

  /// Callable to dismiss the notification.
  VoidCallback get dismiss => throw _privateConstructorUsedError;
  @override

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  Animation<double>? get dismissAnimation => throw _privateConstructorUsedError;
  @override

  /// Reference to the [EncapsuleNotification] these props belong to.
  EncapsuleNotification get reference => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EncapsuleNotificationPropsCopyWith<_$_EncapsuleNotificationProps>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EncapsuleNotification {
  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  EncapsuleNotificationBuilder get builder =>
      throw _privateConstructorUsedError;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  Duration? get timeout => throw _privateConstructorUsedError;

  /// Callback on dismiss.
  VoidCallback? get onDismissed => throw _privateConstructorUsedError;

  /// Dim the background behind the notification and intercept pop.
  bool get important => throw _privateConstructorUsedError;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;

  /// Reference to the previous [EncapsuleNotification].
  EncapsuleNotification? get previous => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsuleNotificationCopyWith<EncapsuleNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsuleNotificationCopyWith<$Res> {
  factory $EncapsuleNotificationCopyWith(EncapsuleNotification value,
          $Res Function(EncapsuleNotification) then) =
      _$EncapsuleNotificationCopyWithImpl<$Res>;
  $Res call(
      {String? tag,
      EncapsuleNotificationBuilder builder,
      Duration? timeout,
      VoidCallback? onDismissed,
      bool important,
      bool dismissible,
      EncapsuleNotification? previous});

  $EncapsuleNotificationCopyWith<$Res>? get previous;
}

/// @nodoc
class _$EncapsuleNotificationCopyWithImpl<$Res>
    implements $EncapsuleNotificationCopyWith<$Res> {
  _$EncapsuleNotificationCopyWithImpl(this._value, this._then);

  final EncapsuleNotification _value;
  // ignore: unused_field
  final $Res Function(EncapsuleNotification) _then;

  @override
  $Res call({
    Object? tag = freezed,
    Object? builder = freezed,
    Object? timeout = freezed,
    Object? onDismissed = freezed,
    Object? important = freezed,
    Object? dismissible = freezed,
    Object? previous = freezed,
  }) {
    return _then(_value.copyWith(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotificationBuilder,
      timeout: timeout == freezed
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      important: important == freezed
          ? _value.important
          : important // ignore: cast_nullable_to_non_nullable
              as bool,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotification?,
    ));
  }

  @override
  $EncapsuleNotificationCopyWith<$Res>? get previous {
    if (_value.previous == null) {
      return null;
    }

    return $EncapsuleNotificationCopyWith<$Res>(_value.previous!, (value) {
      return _then(_value.copyWith(previous: value));
    });
  }
}

/// @nodoc
abstract class _$$_EncapsuleNotificationCopyWith<$Res>
    implements $EncapsuleNotificationCopyWith<$Res> {
  factory _$$_EncapsuleNotificationCopyWith(_$_EncapsuleNotification value,
          $Res Function(_$_EncapsuleNotification) then) =
      __$$_EncapsuleNotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? tag,
      EncapsuleNotificationBuilder builder,
      Duration? timeout,
      VoidCallback? onDismissed,
      bool important,
      bool dismissible,
      EncapsuleNotification? previous});

  @override
  $EncapsuleNotificationCopyWith<$Res>? get previous;
}

/// @nodoc
class __$$_EncapsuleNotificationCopyWithImpl<$Res>
    extends _$EncapsuleNotificationCopyWithImpl<$Res>
    implements _$$_EncapsuleNotificationCopyWith<$Res> {
  __$$_EncapsuleNotificationCopyWithImpl(_$_EncapsuleNotification _value,
      $Res Function(_$_EncapsuleNotification) _then)
      : super(_value, (v) => _then(v as _$_EncapsuleNotification));

  @override
  _$_EncapsuleNotification get _value =>
      super._value as _$_EncapsuleNotification;

  @override
  $Res call({
    Object? tag = freezed,
    Object? builder = freezed,
    Object? timeout = freezed,
    Object? onDismissed = freezed,
    Object? important = freezed,
    Object? dismissible = freezed,
    Object? previous = freezed,
  }) {
    return _then(_$_EncapsuleNotification(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotificationBuilder,
      timeout: timeout == freezed
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      important: important == freezed
          ? _value.important
          : important // ignore: cast_nullable_to_non_nullable
              as bool,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as EncapsuleNotification?,
    ));
  }
}

/// @nodoc

class _$_EncapsuleNotification extends _EncapsuleNotification {
  _$_EncapsuleNotification(
      {this.tag,
      required this.builder,
      this.timeout = const Duration(seconds: 5),
      this.onDismissed,
      this.important = false,
      this.dismissible = true,
      this.previous})
      : assert(timeout == null || timeout >= const Duration(seconds: 5)),
        assert(important == false || timeout == null),
        super._();

  /// Tag to differentiate multiple active notifications.
  @override
  final String? tag;

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  @override
  final EncapsuleNotificationBuilder builder;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  @override
  @JsonKey()
  final Duration? timeout;

  /// Callback on dismiss.
  @override
  final VoidCallback? onDismissed;

  /// Dim the background behind the notification and intercept pop.
  @override
  @JsonKey()
  final bool important;

  /// Wether the user is allowed to manually dismiss this notification.
  @override
  @JsonKey()
  final bool dismissible;

  /// Reference to the previous [EncapsuleNotification].
  @override
  final EncapsuleNotification? previous;

  @override
  String toString() {
    return 'EncapsuleNotification(tag: $tag, builder: $builder, timeout: $timeout, onDismissed: $onDismissed, important: $important, dismissible: $dismissible, previous: $previous)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncapsuleNotification &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            (identical(other.builder, builder) || other.builder == builder) &&
            const DeepCollectionEquality().equals(other.timeout, timeout) &&
            (identical(other.onDismissed, onDismissed) ||
                other.onDismissed == onDismissed) &&
            const DeepCollectionEquality().equals(other.important, important) &&
            const DeepCollectionEquality()
                .equals(other.dismissible, dismissible) &&
            const DeepCollectionEquality().equals(other.previous, previous));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tag),
      builder,
      const DeepCollectionEquality().hash(timeout),
      onDismissed,
      const DeepCollectionEquality().hash(important),
      const DeepCollectionEquality().hash(dismissible),
      const DeepCollectionEquality().hash(previous));

  @JsonKey(ignore: true)
  @override
  _$$_EncapsuleNotificationCopyWith<_$_EncapsuleNotification> get copyWith =>
      __$$_EncapsuleNotificationCopyWithImpl<_$_EncapsuleNotification>(
          this, _$identity);
}

abstract class _EncapsuleNotification extends EncapsuleNotification {
  factory _EncapsuleNotification(
      {final String? tag,
      required final EncapsuleNotificationBuilder builder,
      final Duration? timeout,
      final VoidCallback? onDismissed,
      final bool important,
      final bool dismissible,
      final EncapsuleNotification? previous}) = _$_EncapsuleNotification;
  _EncapsuleNotification._() : super._();

  @override

  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;
  @override

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  EncapsuleNotificationBuilder get builder =>
      throw _privateConstructorUsedError;
  @override

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  Duration? get timeout => throw _privateConstructorUsedError;
  @override

  /// Callback on dismiss.
  VoidCallback? get onDismissed => throw _privateConstructorUsedError;
  @override

  /// Dim the background behind the notification and intercept pop.
  bool get important => throw _privateConstructorUsedError;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;
  @override

  /// Reference to the previous [EncapsuleNotification].
  EncapsuleNotification? get previous => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EncapsuleNotificationCopyWith<_$_EncapsuleNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
