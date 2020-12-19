// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'encapsulated_sheet_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$EncapsulatedSheetItemTearOff {
  const _$EncapsulatedSheetItemTearOff();

// ignore: unused_element
  _EncapsulatedSheetItem<T> call<T>(
      {String tag,
      @required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      List<T> Function(BuildContext) buttons,
      void Function() onDismissed,
      bool dismissible = true}) {
    return _EncapsulatedSheetItem<T>(
      tag: tag,
      builder: builder,
      containerBuilder: containerBuilder,
      buttons: buttons,
      onDismissed: onDismissed,
      dismissible: dismissible,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $EncapsulatedSheetItem = _$EncapsulatedSheetItemTearOff();

/// @nodoc
mixin _$EncapsulatedSheetItem<T> {
  /// Tag to differentiate multiple active notifications.
  String get tag;

  /// Sheet body builder.
  Widget Function(BuildContext, void Function()) get builder;

  /// Sheet body's container builder.
  Widget Function(BuildContext, Animation<double>, Widget) get containerBuilder;

  /// List of buttons.
  List<T> Function(BuildContext) get buttons;

  /// Callback on dismiss.
  void Function() get onDismissed;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;

  $EncapsulatedSheetItemCopyWith<T, EncapsulatedSheetItem<T>> get copyWith;
}

/// @nodoc
abstract class $EncapsulatedSheetItemCopyWith<T, $Res> {
  factory $EncapsulatedSheetItemCopyWith(EncapsulatedSheetItem<T> value,
          $Res Function(EncapsulatedSheetItem<T>) then) =
      _$EncapsulatedSheetItemCopyWithImpl<T, $Res>;
  $Res call(
      {String tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      List<T> Function(BuildContext) buttons,
      void Function() onDismissed,
      bool dismissible});
}

/// @nodoc
class _$EncapsulatedSheetItemCopyWithImpl<T, $Res>
    implements $EncapsulatedSheetItemCopyWith<T, $Res> {
  _$EncapsulatedSheetItemCopyWithImpl(this._value, this._then);

  final EncapsulatedSheetItem<T> _value;
  // ignore: unused_field
  final $Res Function(EncapsulatedSheetItem<T>) _then;

  @override
  $Res call({
    Object tag = freezed,
    Object builder = freezed,
    Object containerBuilder = freezed,
    Object buttons = freezed,
    Object onDismissed = freezed,
    Object dismissible = freezed,
  }) {
    return _then(_value.copyWith(
      tag: tag == freezed ? _value.tag : tag as String,
      builder: builder == freezed
          ? _value.builder
          : builder as Widget Function(BuildContext, void Function()),
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder as Widget Function(
              BuildContext, Animation<double>, Widget),
      buttons: buttons == freezed
          ? _value.buttons
          : buttons as List<T> Function(BuildContext),
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
    ));
  }
}

/// @nodoc
abstract class _$EncapsulatedSheetItemCopyWith<T, $Res>
    implements $EncapsulatedSheetItemCopyWith<T, $Res> {
  factory _$EncapsulatedSheetItemCopyWith(_EncapsulatedSheetItem<T> value,
          $Res Function(_EncapsulatedSheetItem<T>) then) =
      __$EncapsulatedSheetItemCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {String tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      List<T> Function(BuildContext) buttons,
      void Function() onDismissed,
      bool dismissible});
}

/// @nodoc
class __$EncapsulatedSheetItemCopyWithImpl<T, $Res>
    extends _$EncapsulatedSheetItemCopyWithImpl<T, $Res>
    implements _$EncapsulatedSheetItemCopyWith<T, $Res> {
  __$EncapsulatedSheetItemCopyWithImpl(_EncapsulatedSheetItem<T> _value,
      $Res Function(_EncapsulatedSheetItem<T>) _then)
      : super(_value, (v) => _then(v as _EncapsulatedSheetItem<T>));

  @override
  _EncapsulatedSheetItem<T> get _value =>
      super._value as _EncapsulatedSheetItem<T>;

  @override
  $Res call({
    Object tag = freezed,
    Object builder = freezed,
    Object containerBuilder = freezed,
    Object buttons = freezed,
    Object onDismissed = freezed,
    Object dismissible = freezed,
  }) {
    return _then(_EncapsulatedSheetItem<T>(
      tag: tag == freezed ? _value.tag : tag as String,
      builder: builder == freezed
          ? _value.builder
          : builder as Widget Function(BuildContext, void Function()),
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder as Widget Function(
              BuildContext, Animation<double>, Widget),
      buttons: buttons == freezed
          ? _value.buttons
          : buttons as List<T> Function(BuildContext),
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedSheetItem<T> extends _EncapsulatedSheetItem<T> {
  _$_EncapsulatedSheetItem(
      {this.tag,
      @required this.builder,
      this.containerBuilder,
      this.buttons,
      this.onDismissed,
      this.dismissible = true})
      : assert(builder != null),
        assert(dismissible != null),
        super._();

  @override

  /// Tag to differentiate multiple active notifications.
  final String tag;
  @override

  /// Sheet body builder.
  final Widget Function(BuildContext, void Function()) builder;
  @override

  /// Sheet body's container builder.
  final Widget Function(BuildContext, Animation<double>, Widget)
      containerBuilder;
  @override

  /// List of buttons.
  final List<T> Function(BuildContext) buttons;
  @override

  /// Callback on dismiss.
  final void Function() onDismissed;
  @JsonKey(defaultValue: true)
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  final bool dismissible;

  @override
  String toString() {
    return 'EncapsulatedSheetItem<$T>(tag: $tag, builder: $builder, containerBuilder: $containerBuilder, buttons: $buttons, onDismissed: $onDismissed, dismissible: $dismissible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsulatedSheetItem<T> &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.builder, builder) ||
                const DeepCollectionEquality()
                    .equals(other.builder, builder)) &&
            (identical(other.containerBuilder, containerBuilder) ||
                const DeepCollectionEquality()
                    .equals(other.containerBuilder, containerBuilder)) &&
            (identical(other.buttons, buttons) ||
                const DeepCollectionEquality()
                    .equals(other.buttons, buttons)) &&
            (identical(other.onDismissed, onDismissed) ||
                const DeepCollectionEquality()
                    .equals(other.onDismissed, onDismissed)) &&
            (identical(other.dismissible, dismissible) ||
                const DeepCollectionEquality()
                    .equals(other.dismissible, dismissible)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(builder) ^
      const DeepCollectionEquality().hash(containerBuilder) ^
      const DeepCollectionEquality().hash(buttons) ^
      const DeepCollectionEquality().hash(onDismissed) ^
      const DeepCollectionEquality().hash(dismissible);

  @override
  _$EncapsulatedSheetItemCopyWith<T, _EncapsulatedSheetItem<T>> get copyWith =>
      __$EncapsulatedSheetItemCopyWithImpl<T, _EncapsulatedSheetItem<T>>(
          this, _$identity);
}

abstract class _EncapsulatedSheetItem<T> extends EncapsulatedSheetItem<T> {
  _EncapsulatedSheetItem._() : super._();
  factory _EncapsulatedSheetItem(
      {String tag,
      @required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      List<T> Function(BuildContext) buttons,
      void Function() onDismissed,
      bool dismissible}) = _$_EncapsulatedSheetItem<T>;

  @override

  /// Tag to differentiate multiple active notifications.
  String get tag;
  @override

  /// Sheet body builder.
  Widget Function(BuildContext, void Function()) get builder;
  @override

  /// Sheet body's container builder.
  Widget Function(BuildContext, Animation<double>, Widget) get containerBuilder;
  @override

  /// List of buttons.
  List<T> Function(BuildContext) get buttons;
  @override

  /// Callback on dismiss.
  void Function() get onDismissed;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;
  @override
  _$EncapsulatedSheetItemCopyWith<T, _EncapsulatedSheetItem<T>> get copyWith;
}
