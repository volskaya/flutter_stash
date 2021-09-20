// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'encapsule_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EncapsuleNotificationPropsTearOff {
  const _$EncapsuleNotificationPropsTearOff();

  _EncapsuleNotificationProps call(
      {required void Function() dismiss,
      Animation<double>? dismissAnimation,
      required EncapsuleNotification reference}) {
    return _EncapsuleNotificationProps(
      dismiss: dismiss,
      dismissAnimation: dismissAnimation,
      reference: reference,
    );
  }
}

/// @nodoc
const $EncapsuleNotificationProps = _$EncapsuleNotificationPropsTearOff();

/// @nodoc
mixin _$EncapsuleNotificationProps {
  /// Callable to dismiss the notification.
  void Function() get dismiss => throw _privateConstructorUsedError;

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
      {void Function() dismiss,
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
              as void Function(),
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
abstract class _$EncapsuleNotificationPropsCopyWith<$Res>
    implements $EncapsuleNotificationPropsCopyWith<$Res> {
  factory _$EncapsuleNotificationPropsCopyWith(
          _EncapsuleNotificationProps value,
          $Res Function(_EncapsuleNotificationProps) then) =
      __$EncapsuleNotificationPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {void Function() dismiss,
      Animation<double>? dismissAnimation,
      EncapsuleNotification reference});

  @override
  $EncapsuleNotificationCopyWith<$Res> get reference;
}

/// @nodoc
class __$EncapsuleNotificationPropsCopyWithImpl<$Res>
    extends _$EncapsuleNotificationPropsCopyWithImpl<$Res>
    implements _$EncapsuleNotificationPropsCopyWith<$Res> {
  __$EncapsuleNotificationPropsCopyWithImpl(_EncapsuleNotificationProps _value,
      $Res Function(_EncapsuleNotificationProps) _then)
      : super(_value, (v) => _then(v as _EncapsuleNotificationProps));

  @override
  _EncapsuleNotificationProps get _value =>
      super._value as _EncapsuleNotificationProps;

  @override
  $Res call({
    Object? dismiss = freezed,
    Object? dismissAnimation = freezed,
    Object? reference = freezed,
  }) {
    return _then(_EncapsuleNotificationProps(
      dismiss: dismiss == freezed
          ? _value.dismiss
          : dismiss // ignore: cast_nullable_to_non_nullable
              as void Function(),
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

  @override

  /// Callable to dismiss the notification.
  final void Function() dismiss;
  @override

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  final Animation<double>? dismissAnimation;
  @override

  /// Reference to the [EncapsuleNotification] these props belong to.
  final EncapsuleNotification reference;

  @override
  String toString() {
    return 'EncapsuleNotificationProps(dismiss: $dismiss, dismissAnimation: $dismissAnimation, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsuleNotificationProps &&
            (identical(other.dismiss, dismiss) ||
                const DeepCollectionEquality()
                    .equals(other.dismiss, dismiss)) &&
            (identical(other.dismissAnimation, dismissAnimation) ||
                const DeepCollectionEquality()
                    .equals(other.dismissAnimation, dismissAnimation)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality()
                    .equals(other.reference, reference)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(dismiss) ^
      const DeepCollectionEquality().hash(dismissAnimation) ^
      const DeepCollectionEquality().hash(reference);

  @JsonKey(ignore: true)
  @override
  _$EncapsuleNotificationPropsCopyWith<_EncapsuleNotificationProps>
      get copyWith => __$EncapsuleNotificationPropsCopyWithImpl<
          _EncapsuleNotificationProps>(this, _$identity);
}

abstract class _EncapsuleNotificationProps
    implements EncapsuleNotificationProps {
  const factory _EncapsuleNotificationProps(
          {required void Function() dismiss,
          Animation<double>? dismissAnimation,
          required EncapsuleNotification reference}) =
      _$_EncapsuleNotificationProps;

  @override

  /// Callable to dismiss the notification.
  void Function() get dismiss => throw _privateConstructorUsedError;
  @override

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  Animation<double>? get dismissAnimation => throw _privateConstructorUsedError;
  @override

  /// Reference to the [EncapsuleNotification] these props belong to.
  EncapsuleNotification get reference => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EncapsuleNotificationPropsCopyWith<_EncapsuleNotificationProps>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$EncapsuleNotificationTearOff {
  const _$EncapsuleNotificationTearOff();

  _EncapsuleNotification call(
      {String? tag,
      required Widget Function(
              BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout = const Duration(seconds: 5),
      void Function()? onDismissed,
      bool important = false,
      bool dismissible = true,
      EncapsuleNotification? previous}) {
    return _EncapsuleNotification(
      tag: tag,
      builder: builder,
      timeout: timeout,
      onDismissed: onDismissed,
      important: important,
      dismissible: dismissible,
      previous: previous,
    );
  }
}

/// @nodoc
const $EncapsuleNotification = _$EncapsuleNotificationTearOff();

/// @nodoc
mixin _$EncapsuleNotification {
  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  Widget Function(BuildContext, void Function(), Animation<double>?)
      get builder => throw _privateConstructorUsedError;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  Duration? get timeout => throw _privateConstructorUsedError;

  /// Callback on dismiss.
  void Function()? get onDismissed => throw _privateConstructorUsedError;

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
      Widget Function(BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout,
      void Function()? onDismissed,
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
              as Widget Function(
                  BuildContext, void Function(), Animation<double>?),
      timeout: timeout == freezed
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as void Function()?,
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
abstract class _$EncapsuleNotificationCopyWith<$Res>
    implements $EncapsuleNotificationCopyWith<$Res> {
  factory _$EncapsuleNotificationCopyWith(_EncapsuleNotification value,
          $Res Function(_EncapsuleNotification) then) =
      __$EncapsuleNotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? tag,
      Widget Function(BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout,
      void Function()? onDismissed,
      bool important,
      bool dismissible,
      EncapsuleNotification? previous});

  @override
  $EncapsuleNotificationCopyWith<$Res>? get previous;
}

/// @nodoc
class __$EncapsuleNotificationCopyWithImpl<$Res>
    extends _$EncapsuleNotificationCopyWithImpl<$Res>
    implements _$EncapsuleNotificationCopyWith<$Res> {
  __$EncapsuleNotificationCopyWithImpl(_EncapsuleNotification _value,
      $Res Function(_EncapsuleNotification) _then)
      : super(_value, (v) => _then(v as _EncapsuleNotification));

  @override
  _EncapsuleNotification get _value => super._value as _EncapsuleNotification;

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
    return _then(_EncapsuleNotification(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as Widget Function(
                  BuildContext, void Function(), Animation<double>?),
      timeout: timeout == freezed
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as Duration?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as void Function()?,
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

  @override

  /// Tag to differentiate multiple active notifications.
  final String? tag;
  @override

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  final Widget Function(BuildContext, void Function(), Animation<double>?)
      builder;
  @JsonKey(defaultValue: const Duration(seconds: 5))
  @override

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  final Duration? timeout;
  @override

  /// Callback on dismiss.
  final void Function()? onDismissed;
  @JsonKey(defaultValue: false)
  @override

  /// Dim the background behind the notification and intercept pop.
  final bool important;
  @JsonKey(defaultValue: true)
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  final bool dismissible;
  @override

  /// Reference to the previous [EncapsuleNotification].
  final EncapsuleNotification? previous;

  @override
  String toString() {
    return 'EncapsuleNotification(tag: $tag, builder: $builder, timeout: $timeout, onDismissed: $onDismissed, important: $important, dismissible: $dismissible, previous: $previous)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsuleNotification &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.builder, builder) ||
                const DeepCollectionEquality()
                    .equals(other.builder, builder)) &&
            (identical(other.timeout, timeout) ||
                const DeepCollectionEquality()
                    .equals(other.timeout, timeout)) &&
            (identical(other.onDismissed, onDismissed) ||
                const DeepCollectionEquality()
                    .equals(other.onDismissed, onDismissed)) &&
            (identical(other.important, important) ||
                const DeepCollectionEquality()
                    .equals(other.important, important)) &&
            (identical(other.dismissible, dismissible) ||
                const DeepCollectionEquality()
                    .equals(other.dismissible, dismissible)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality()
                    .equals(other.previous, previous)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(builder) ^
      const DeepCollectionEquality().hash(timeout) ^
      const DeepCollectionEquality().hash(onDismissed) ^
      const DeepCollectionEquality().hash(important) ^
      const DeepCollectionEquality().hash(dismissible) ^
      const DeepCollectionEquality().hash(previous);

  @JsonKey(ignore: true)
  @override
  _$EncapsuleNotificationCopyWith<_EncapsuleNotification> get copyWith =>
      __$EncapsuleNotificationCopyWithImpl<_EncapsuleNotification>(
          this, _$identity);
}

abstract class _EncapsuleNotification extends EncapsuleNotification {
  factory _EncapsuleNotification(
      {String? tag,
      required Widget Function(
              BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout,
      void Function()? onDismissed,
      bool important,
      bool dismissible,
      EncapsuleNotification? previous}) = _$_EncapsuleNotification;
  _EncapsuleNotification._() : super._();

  @override

  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;
  @override

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  Widget Function(BuildContext, void Function(), Animation<double>?)
      get builder => throw _privateConstructorUsedError;
  @override

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  Duration? get timeout => throw _privateConstructorUsedError;
  @override

  /// Callback on dismiss.
  void Function()? get onDismissed => throw _privateConstructorUsedError;
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
  _$EncapsuleNotificationCopyWith<_EncapsuleNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
