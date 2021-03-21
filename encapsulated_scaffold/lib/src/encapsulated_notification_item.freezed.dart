// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'encapsulated_notification_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EncapsulatedNotificationPropsTearOff {
  const _$EncapsulatedNotificationPropsTearOff();

  _EncapsulatedNotificationProps call(
      {required void Function() dismiss,
      Animation<double>? dismissAnimation,
      required EncapsulatedNotificationItem reference}) {
    return _EncapsulatedNotificationProps(
      dismiss: dismiss,
      dismissAnimation: dismissAnimation,
      reference: reference,
    );
  }
}

/// @nodoc
const $EncapsulatedNotificationProps = _$EncapsulatedNotificationPropsTearOff();

/// @nodoc
mixin _$EncapsulatedNotificationProps {
  /// Callable to dismiss the notification.
  void Function() get dismiss => throw _privateConstructorUsedError;

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  Animation<double>? get dismissAnimation => throw _privateConstructorUsedError;

  /// Reference to the [EncapsulatedNotificationItem] these props belong to.
  EncapsulatedNotificationItem get reference =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsulatedNotificationPropsCopyWith<EncapsulatedNotificationProps>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsulatedNotificationPropsCopyWith<$Res> {
  factory $EncapsulatedNotificationPropsCopyWith(
          EncapsulatedNotificationProps value,
          $Res Function(EncapsulatedNotificationProps) then) =
      _$EncapsulatedNotificationPropsCopyWithImpl<$Res>;
  $Res call(
      {void Function() dismiss,
      Animation<double>? dismissAnimation,
      EncapsulatedNotificationItem reference});

  $EncapsulatedNotificationItemCopyWith<$Res> get reference;
}

/// @nodoc
class _$EncapsulatedNotificationPropsCopyWithImpl<$Res>
    implements $EncapsulatedNotificationPropsCopyWith<$Res> {
  _$EncapsulatedNotificationPropsCopyWithImpl(this._value, this._then);

  final EncapsulatedNotificationProps _value;
  // ignore: unused_field
  final $Res Function(EncapsulatedNotificationProps) _then;

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
              as EncapsulatedNotificationItem,
    ));
  }

  @override
  $EncapsulatedNotificationItemCopyWith<$Res> get reference {
    return $EncapsulatedNotificationItemCopyWith<$Res>(_value.reference,
        (value) {
      return _then(_value.copyWith(reference: value));
    });
  }
}

/// @nodoc
abstract class _$EncapsulatedNotificationPropsCopyWith<$Res>
    implements $EncapsulatedNotificationPropsCopyWith<$Res> {
  factory _$EncapsulatedNotificationPropsCopyWith(
          _EncapsulatedNotificationProps value,
          $Res Function(_EncapsulatedNotificationProps) then) =
      __$EncapsulatedNotificationPropsCopyWithImpl<$Res>;
  @override
  $Res call(
      {void Function() dismiss,
      Animation<double>? dismissAnimation,
      EncapsulatedNotificationItem reference});

  @override
  $EncapsulatedNotificationItemCopyWith<$Res> get reference;
}

/// @nodoc
class __$EncapsulatedNotificationPropsCopyWithImpl<$Res>
    extends _$EncapsulatedNotificationPropsCopyWithImpl<$Res>
    implements _$EncapsulatedNotificationPropsCopyWith<$Res> {
  __$EncapsulatedNotificationPropsCopyWithImpl(
      _EncapsulatedNotificationProps _value,
      $Res Function(_EncapsulatedNotificationProps) _then)
      : super(_value, (v) => _then(v as _EncapsulatedNotificationProps));

  @override
  _EncapsulatedNotificationProps get _value =>
      super._value as _EncapsulatedNotificationProps;

  @override
  $Res call({
    Object? dismiss = freezed,
    Object? dismissAnimation = freezed,
    Object? reference = freezed,
  }) {
    return _then(_EncapsulatedNotificationProps(
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
              as EncapsulatedNotificationItem,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedNotificationProps
    implements _EncapsulatedNotificationProps {
  const _$_EncapsulatedNotificationProps(
      {required this.dismiss, this.dismissAnimation, required this.reference});

  @override

  /// Callable to dismiss the notification.
  final void Function() dismiss;
  @override

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  final Animation<double>? dismissAnimation;
  @override

  /// Reference to the [EncapsulatedNotificationItem] these props belong to.
  final EncapsulatedNotificationItem reference;

  @override
  String toString() {
    return 'EncapsulatedNotificationProps(dismiss: $dismiss, dismissAnimation: $dismissAnimation, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsulatedNotificationProps &&
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
  _$EncapsulatedNotificationPropsCopyWith<_EncapsulatedNotificationProps>
      get copyWith => __$EncapsulatedNotificationPropsCopyWithImpl<
          _EncapsulatedNotificationProps>(this, _$identity);
}

abstract class _EncapsulatedNotificationProps
    implements EncapsulatedNotificationProps {
  const factory _EncapsulatedNotificationProps(
          {required void Function() dismiss,
          Animation<double>? dismissAnimation,
          required EncapsulatedNotificationItem reference}) =
      _$_EncapsulatedNotificationProps;

  @override

  /// Callable to dismiss the notification.
  void Function() get dismiss => throw _privateConstructorUsedError;
  @override

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  Animation<double>? get dismissAnimation => throw _privateConstructorUsedError;
  @override

  /// Reference to the [EncapsulatedNotificationItem] these props belong to.
  EncapsulatedNotificationItem get reference =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EncapsulatedNotificationPropsCopyWith<_EncapsulatedNotificationProps>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$EncapsulatedNotificationItemTearOff {
  const _$EncapsulatedNotificationItemTearOff();

  _EncapsulatedNotificationItem call(
      {String? tag,
      required Widget Function(
              BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout = const Duration(seconds: 5),
      void Function()? onDismissed,
      bool important = false,
      bool dismissible = true,
      EncapsulatedNotificationItem? previous}) {
    return _EncapsulatedNotificationItem(
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
const $EncapsulatedNotificationItem = _$EncapsulatedNotificationItemTearOff();

/// @nodoc
mixin _$EncapsulatedNotificationItem {
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

  /// Reference to the previous [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem? get previous =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsulatedNotificationItemCopyWith<EncapsulatedNotificationItem>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsulatedNotificationItemCopyWith<$Res> {
  factory $EncapsulatedNotificationItemCopyWith(
          EncapsulatedNotificationItem value,
          $Res Function(EncapsulatedNotificationItem) then) =
      _$EncapsulatedNotificationItemCopyWithImpl<$Res>;
  $Res call(
      {String? tag,
      Widget Function(BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout,
      void Function()? onDismissed,
      bool important,
      bool dismissible,
      EncapsulatedNotificationItem? previous});

  $EncapsulatedNotificationItemCopyWith<$Res>? get previous;
}

/// @nodoc
class _$EncapsulatedNotificationItemCopyWithImpl<$Res>
    implements $EncapsulatedNotificationItemCopyWith<$Res> {
  _$EncapsulatedNotificationItemCopyWithImpl(this._value, this._then);

  final EncapsulatedNotificationItem _value;
  // ignore: unused_field
  final $Res Function(EncapsulatedNotificationItem) _then;

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
              as EncapsulatedNotificationItem?,
    ));
  }

  @override
  $EncapsulatedNotificationItemCopyWith<$Res>? get previous {
    if (_value.previous == null) {
      return null;
    }

    return $EncapsulatedNotificationItemCopyWith<$Res>(_value.previous!,
        (value) {
      return _then(_value.copyWith(previous: value));
    });
  }
}

/// @nodoc
abstract class _$EncapsulatedNotificationItemCopyWith<$Res>
    implements $EncapsulatedNotificationItemCopyWith<$Res> {
  factory _$EncapsulatedNotificationItemCopyWith(
          _EncapsulatedNotificationItem value,
          $Res Function(_EncapsulatedNotificationItem) then) =
      __$EncapsulatedNotificationItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? tag,
      Widget Function(BuildContext, void Function(), Animation<double>?)
          builder,
      Duration? timeout,
      void Function()? onDismissed,
      bool important,
      bool dismissible,
      EncapsulatedNotificationItem? previous});

  @override
  $EncapsulatedNotificationItemCopyWith<$Res>? get previous;
}

/// @nodoc
class __$EncapsulatedNotificationItemCopyWithImpl<$Res>
    extends _$EncapsulatedNotificationItemCopyWithImpl<$Res>
    implements _$EncapsulatedNotificationItemCopyWith<$Res> {
  __$EncapsulatedNotificationItemCopyWithImpl(
      _EncapsulatedNotificationItem _value,
      $Res Function(_EncapsulatedNotificationItem) _then)
      : super(_value, (v) => _then(v as _EncapsulatedNotificationItem));

  @override
  _EncapsulatedNotificationItem get _value =>
      super._value as _EncapsulatedNotificationItem;

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
    return _then(_EncapsulatedNotificationItem(
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
              as EncapsulatedNotificationItem?,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedNotificationItem extends _EncapsulatedNotificationItem {
  _$_EncapsulatedNotificationItem(
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

  /// Reference to the previous [EncapsulatedNotificationItem].
  final EncapsulatedNotificationItem? previous;

  @override
  String toString() {
    return 'EncapsulatedNotificationItem(tag: $tag, builder: $builder, timeout: $timeout, onDismissed: $onDismissed, important: $important, dismissible: $dismissible, previous: $previous)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsulatedNotificationItem &&
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
  _$EncapsulatedNotificationItemCopyWith<_EncapsulatedNotificationItem>
      get copyWith => __$EncapsulatedNotificationItemCopyWithImpl<
          _EncapsulatedNotificationItem>(this, _$identity);
}

abstract class _EncapsulatedNotificationItem
    extends EncapsulatedNotificationItem {
  factory _EncapsulatedNotificationItem(
          {String? tag,
          required Widget Function(
                  BuildContext, void Function(), Animation<double>?)
              builder,
          Duration? timeout,
          void Function()? onDismissed,
          bool important,
          bool dismissible,
          EncapsulatedNotificationItem? previous}) =
      _$_EncapsulatedNotificationItem;
  _EncapsulatedNotificationItem._() : super._();

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

  /// Reference to the previous [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem? get previous =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EncapsulatedNotificationItemCopyWith<_EncapsulatedNotificationItem>
      get copyWith => throw _privateConstructorUsedError;
}
