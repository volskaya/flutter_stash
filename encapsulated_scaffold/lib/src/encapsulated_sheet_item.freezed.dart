// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'encapsulated_sheet_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EncapsulatedSheetItemTearOff {
  const _$EncapsulatedSheetItemTearOff();

  _EncapsulatedSheetItem call(
      {String? tag,
      required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget)?
          containerBuilder,
      void Function()? onDismissed,
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
const $EncapsulatedSheetItem = _$EncapsulatedSheetItemTearOff();

/// @nodoc
mixin _$EncapsulatedSheetItem {
  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;

  /// Sheet body builder.
  Widget Function(BuildContext, void Function()) get builder =>
      throw _privateConstructorUsedError;

  /// Sheet body's container builder.
  Widget Function(BuildContext, Animation<double>, Widget)?
      get containerBuilder => throw _privateConstructorUsedError;

  /// Callback on dismiss.
  void Function()? get onDismissed => throw _privateConstructorUsedError;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsulatedSheetItemCopyWith<EncapsulatedSheetItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsulatedSheetItemCopyWith<$Res> {
  factory $EncapsulatedSheetItemCopyWith(EncapsulatedSheetItem value,
          $Res Function(EncapsulatedSheetItem) then) =
      _$EncapsulatedSheetItemCopyWithImpl<$Res>;
  $Res call(
      {String? tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget)?
          containerBuilder,
      void Function()? onDismissed,
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
    Object? tag = freezed,
    Object? builder = freezed,
    Object? containerBuilder = freezed,
    Object? onDismissed = freezed,
    Object? dismissible = freezed,
  }) {
    return _then(_value.copyWith(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, void Function()),
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, Animation<double>, Widget)?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as void Function()?,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {String? tag,
      Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget)?
          containerBuilder,
      void Function()? onDismissed,
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
    Object? tag = freezed,
    Object? builder = freezed,
    Object? containerBuilder = freezed,
    Object? onDismissed = freezed,
    Object? dismissible = freezed,
  }) {
    return _then(_EncapsulatedSheetItem(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, void Function()),
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, Animation<double>, Widget)?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as void Function()?,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
class _$_EncapsulatedSheetItem extends _EncapsulatedSheetItem {
  _$_EncapsulatedSheetItem(
      {this.tag,
      required this.builder,
      this.containerBuilder,
      this.onDismissed,
      this.dismissible = true})
      : super._();

  @override

  /// Tag to differentiate multiple active notifications.
  final String? tag;
  @override

  /// Sheet body builder.
  final Widget Function(BuildContext, void Function()) builder;
  @override

  /// Sheet body's container builder.
  final Widget Function(BuildContext, Animation<double>, Widget)?
      containerBuilder;
  @override

  /// Callback on dismiss.
  final void Function()? onDismissed;
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

  @JsonKey(ignore: true)
  @override
  _$EncapsulatedSheetItemCopyWith<_EncapsulatedSheetItem> get copyWith =>
      __$EncapsulatedSheetItemCopyWithImpl<_EncapsulatedSheetItem>(
          this, _$identity);
}

abstract class _EncapsulatedSheetItem extends EncapsulatedSheetItem {
  factory _EncapsulatedSheetItem(
      {String? tag,
      required Widget Function(BuildContext, void Function()) builder,
      Widget Function(BuildContext, Animation<double>, Widget)?
          containerBuilder,
      void Function()? onDismissed,
      bool dismissible}) = _$_EncapsulatedSheetItem;
  _EncapsulatedSheetItem._() : super._();

  @override

  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;
  @override

  /// Sheet body builder.
  Widget Function(BuildContext, void Function()) get builder =>
      throw _privateConstructorUsedError;
  @override

  /// Sheet body's container builder.
  Widget Function(BuildContext, Animation<double>, Widget)?
      get containerBuilder => throw _privateConstructorUsedError;
  @override

  /// Callback on dismiss.
  void Function()? get onDismissed => throw _privateConstructorUsedError;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EncapsulatedSheetItemCopyWith<_EncapsulatedSheetItem> get copyWith =>
      throw _privateConstructorUsedError;
}
