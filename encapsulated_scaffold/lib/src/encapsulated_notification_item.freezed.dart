// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'encapsulated_notification_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$EncapsulatedNotificationItemTearOff {
  const _$EncapsulatedNotificationItemTearOff();

// ignore: unused_element
  _EncapsulatedNotificationItem call(
      {String tag,
      @required
          Widget Function(BuildContext, void Function(), Animation<double>)
              builder,
      @nullable
          Duration timeout = const Duration(seconds: 10),
      void Function() onDismissed,
      bool important = false,
      bool dismissible = true,
      EncapsulatedNotificationItem previous}) {
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
// ignore: unused_element
const $EncapsulatedNotificationItem = _$EncapsulatedNotificationItemTearOff();

/// @nodoc
mixin _$EncapsulatedNotificationItem {
  /// Tag to differentiate multiple active notifications.
  String get tag;

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  Widget Function(BuildContext, void Function(), Animation<double>) get builder;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  @nullable
  Duration get timeout;

  /// Callback on dismiss.
  void Function() get onDismissed;

  /// Dim the background behind the notification and intercept pop.
  bool get important;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;

  /// Reference to the previous [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem get previous;

  $EncapsulatedNotificationItemCopyWith<EncapsulatedNotificationItem>
      get copyWith;
}

/// @nodoc
abstract class $EncapsulatedNotificationItemCopyWith<$Res> {
  factory $EncapsulatedNotificationItemCopyWith(
          EncapsulatedNotificationItem value,
          $Res Function(EncapsulatedNotificationItem) then) =
      _$EncapsulatedNotificationItemCopyWithImpl<$Res>;
  $Res call(
      {String tag,
      Widget Function(BuildContext, void Function(), Animation<double>) builder,
      @nullable Duration timeout,
      void Function() onDismissed,
      bool important,
      bool dismissible,
      EncapsulatedNotificationItem previous});

  $EncapsulatedNotificationItemCopyWith<$Res> get previous;
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
    Object tag = freezed,
    Object builder = freezed,
    Object timeout = freezed,
    Object onDismissed = freezed,
    Object important = freezed,
    Object dismissible = freezed,
    Object previous = freezed,
  }) {
    return _then(_value.copyWith(
      tag: tag == freezed ? _value.tag : tag as String,
      builder: builder == freezed
          ? _value.builder
          : builder as Widget Function(
              BuildContext, void Function(), Animation<double>),
      timeout: timeout == freezed ? _value.timeout : timeout as Duration,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      important: important == freezed ? _value.important : important as bool,
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
      previous: previous == freezed
          ? _value.previous
          : previous as EncapsulatedNotificationItem,
    ));
  }

  @override
  $EncapsulatedNotificationItemCopyWith<$Res> get previous {
    if (_value.previous == null) {
      return null;
    }
    return $EncapsulatedNotificationItemCopyWith<$Res>(_value.previous,
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
      {String tag,
      Widget Function(BuildContext, void Function(), Animation<double>) builder,
      @nullable Duration timeout,
      void Function() onDismissed,
      bool important,
      bool dismissible,
      EncapsulatedNotificationItem previous});

  @override
  $EncapsulatedNotificationItemCopyWith<$Res> get previous;
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
    Object tag = freezed,
    Object builder = freezed,
    Object timeout = freezed,
    Object onDismissed = freezed,
    Object important = freezed,
    Object dismissible = freezed,
    Object previous = freezed,
  }) {
    return _then(_EncapsulatedNotificationItem(
      tag: tag == freezed ? _value.tag : tag as String,
      builder: builder == freezed
          ? _value.builder
          : builder as Widget Function(
              BuildContext, void Function(), Animation<double>),
      timeout: timeout == freezed ? _value.timeout : timeout as Duration,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      important: important == freezed ? _value.important : important as bool,
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
      previous: previous == freezed
          ? _value.previous
          : previous as EncapsulatedNotificationItem,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedNotificationItem extends _EncapsulatedNotificationItem {
  _$_EncapsulatedNotificationItem(
      {this.tag,
      @required this.builder,
      @nullable this.timeout = const Duration(seconds: 10),
      this.onDismissed,
      this.important = false,
      this.dismissible = true,
      this.previous})
      : assert(builder != null),
        assert(important != null),
        assert(dismissible != null),
        assert(timeout == null || timeout >= const Duration(seconds: 5)),
        assert(important == false || timeout == null),
        super._();

  @override

  /// Tag to differentiate multiple active notifications.
  final String tag;
  @override

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  final Widget Function(BuildContext, void Function(), Animation<double>)
      builder;
  @JsonKey(defaultValue: const Duration(seconds: 10))
  @override

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  @nullable
  final Duration timeout;
  @override

  /// Callback on dismiss.
  final void Function() onDismissed;
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
  final EncapsulatedNotificationItem previous;

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

  @override
  _$EncapsulatedNotificationItemCopyWith<_EncapsulatedNotificationItem>
      get copyWith => __$EncapsulatedNotificationItemCopyWithImpl<
          _EncapsulatedNotificationItem>(this, _$identity);
}

abstract class _EncapsulatedNotificationItem
    extends EncapsulatedNotificationItem {
  _EncapsulatedNotificationItem._() : super._();
  factory _EncapsulatedNotificationItem(
      {String tag,
      @required
          Widget Function(BuildContext, void Function(), Animation<double>)
              builder,
      @nullable
          Duration timeout,
      void Function() onDismissed,
      bool important,
      bool dismissible,
      EncapsulatedNotificationItem previous}) = _$_EncapsulatedNotificationItem;

  @override

  /// Tag to differentiate multiple active notifications.
  String get tag;
  @override

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  Widget Function(BuildContext, void Function(), Animation<double>) get builder;
  @override

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  @nullable
  Duration get timeout;
  @override

  /// Callback on dismiss.
  void Function() get onDismissed;
  @override

  /// Dim the background behind the notification and intercept pop.
  bool get important;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;
  @override

  /// Reference to the previous [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem get previous;
  @override
  _$EncapsulatedNotificationItemCopyWith<_EncapsulatedNotificationItem>
      get copyWith;
}