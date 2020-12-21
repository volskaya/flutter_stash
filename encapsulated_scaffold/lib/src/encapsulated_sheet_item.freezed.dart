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
  _EncapsulatedSheetItem call(
      {String tag,
      @required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      void Function() onDismissed,
      bool dismissible = true}) {
    return _EncapsulatedSheetItem(
      tag: tag,
      builder: builder,
      containerBuilder: containerBuilder,
      onDismissed: onDismissed,
      dismissible: dismissible,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $EncapsulatedSheetItem = _$EncapsulatedSheetItemTearOff();

/// @nodoc
mixin _$EncapsulatedSheetItem {
  /// Tag to differentiate multiple active notifications.
  String get tag;

  /// Sheet body builder.
  Widget Function(BuildContext, void Function()) get builder;

  /// Sheet body's container builder.
  Widget Function(BuildContext, Animation<double>, Widget) get containerBuilder;

  /// Callback on dismiss.
  void Function() get onDismissed;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;

  $EncapsulatedSheetItemCopyWith<EncapsulatedSheetItem> get copyWith;
}

/// @nodoc
abstract class $EncapsulatedSheetItemCopyWith<$Res> {
  factory $EncapsulatedSheetItemCopyWith(EncapsulatedSheetItem value,
          $Res Function(EncapsulatedSheetItem) then) =
      _$EncapsulatedSheetItemCopyWithImpl<$Res>;
  $Res call(
      {String tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      void Function() onDismissed,
      bool dismissible});
}

/// @nodoc
class _$EncapsulatedSheetItemCopyWithImpl<$Res>
    implements $EncapsulatedSheetItemCopyWith<$Res> {
  _$EncapsulatedSheetItemCopyWithImpl(this._value, this._then);

  final EncapsulatedSheetItem _value;
  // ignore: unused_field
  final $Res Function(EncapsulatedSheetItem) _then;

  @override
  $Res call({
    Object tag = freezed,
    Object builder = freezed,
    Object containerBuilder = freezed,
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
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
    ));
  }
}

/// @nodoc
abstract class _$EncapsulatedSheetItemCopyWith<$Res>
    implements $EncapsulatedSheetItemCopyWith<$Res> {
  factory _$EncapsulatedSheetItemCopyWith(_EncapsulatedSheetItem value,
          $Res Function(_EncapsulatedSheetItem) then) =
      __$EncapsulatedSheetItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      void Function() onDismissed,
      bool dismissible});
}

/// @nodoc
class __$EncapsulatedSheetItemCopyWithImpl<$Res>
    extends _$EncapsulatedSheetItemCopyWithImpl<$Res>
    implements _$EncapsulatedSheetItemCopyWith<$Res> {
  __$EncapsulatedSheetItemCopyWithImpl(_EncapsulatedSheetItem _value,
      $Res Function(_EncapsulatedSheetItem) _then)
      : super(_value, (v) => _then(v as _EncapsulatedSheetItem));

  @override
  _EncapsulatedSheetItem get _value => super._value as _EncapsulatedSheetItem;

  @override
  $Res call({
    Object tag = freezed,
    Object builder = freezed,
    Object containerBuilder = freezed,
    Object onDismissed = freezed,
    Object dismissible = freezed,
  }) {
    return _then(_EncapsulatedSheetItem(
      tag: tag == freezed ? _value.tag : tag as String,
      builder: builder == freezed
          ? _value.builder
          : builder as Widget Function(BuildContext, void Function()),
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder as Widget Function(
              BuildContext, Animation<double>, Widget),
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed as void Function(),
      dismissible:
          dismissible == freezed ? _value.dismissible : dismissible as bool,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedSheetItem extends _EncapsulatedSheetItem {
  _$_EncapsulatedSheetItem(
      {this.tag,
      @required this.builder,
      this.containerBuilder,
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

  /// Callback on dismiss.
  final void Function() onDismissed;
  @JsonKey(defaultValue: true)
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  final bool dismissible;

  @override
  String toString() {
    return 'EncapsulatedSheetItem(tag: $tag, builder: $builder, containerBuilder: $containerBuilder, onDismissed: $onDismissed, dismissible: $dismissible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EncapsulatedSheetItem &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.builder, builder) ||
                const DeepCollectionEquality()
                    .equals(other.builder, builder)) &&
            (identical(other.containerBuilder, containerBuilder) ||
                const DeepCollectionEquality()
                    .equals(other.containerBuilder, containerBuilder)) &&
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
      const DeepCollectionEquality().hash(onDismissed) ^
      const DeepCollectionEquality().hash(dismissible);

  @override
  _$EncapsulatedSheetItemCopyWith<_EncapsulatedSheetItem> get copyWith =>
      __$EncapsulatedSheetItemCopyWithImpl<_EncapsulatedSheetItem>(
          this, _$identity);
}

abstract class _EncapsulatedSheetItem extends EncapsulatedSheetItem {
  _EncapsulatedSheetItem._() : super._();
  factory _EncapsulatedSheetItem(
      {String tag,
      @required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget) containerBuilder,
      void Function() onDismissed,
      bool dismissible}) = _$_EncapsulatedSheetItem;

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

  /// Callback on dismiss.
  void Function() get onDismissed;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible;
  @override
  _$EncapsulatedSheetItemCopyWith<_EncapsulatedSheetItem> get copyWith;
}
