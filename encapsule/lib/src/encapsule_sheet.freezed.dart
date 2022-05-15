// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'encapsule_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EncapsuleSheet {
  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;

  /// Sheet body builder.
  EncapsuleSheetBuilder get builder => throw _privateConstructorUsedError;

  /// Sheet body's container builder.
  EncapsuleSheetContainerBuilder? get containerBuilder =>
      throw _privateConstructorUsedError;

  /// Callback on dismiss.
  VoidCallback? get onDismissed => throw _privateConstructorUsedError;

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsuleSheetCopyWith<EncapsuleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsuleSheetCopyWith<$Res> {
  factory $EncapsuleSheetCopyWith(
          EncapsuleSheet value, $Res Function(EncapsuleSheet) then) =
      _$EncapsuleSheetCopyWithImpl<$Res>;
  $Res call(
      {String? tag,
      EncapsuleSheetBuilder builder,
      EncapsuleSheetContainerBuilder? containerBuilder,
      VoidCallback? onDismissed,
      bool dismissible});
}

/// @nodoc
class _$EncapsuleSheetCopyWithImpl<$Res>
    implements $EncapsuleSheetCopyWith<$Res> {
  _$EncapsuleSheetCopyWithImpl(this._value, this._then);

  final EncapsuleSheet _value;
  // ignore: unused_field
  final $Res Function(EncapsuleSheet) _then;

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
              as EncapsuleSheetBuilder,
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder // ignore: cast_nullable_to_non_nullable
              as EncapsuleSheetContainerBuilder?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_EncapsuleSheetCopyWith<$Res>
    implements $EncapsuleSheetCopyWith<$Res> {
  factory _$$_EncapsuleSheetCopyWith(
          _$_EncapsuleSheet value, $Res Function(_$_EncapsuleSheet) then) =
      __$$_EncapsuleSheetCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? tag,
      EncapsuleSheetBuilder builder,
      EncapsuleSheetContainerBuilder? containerBuilder,
      VoidCallback? onDismissed,
      bool dismissible});
}

/// @nodoc
class __$$_EncapsuleSheetCopyWithImpl<$Res>
    extends _$EncapsuleSheetCopyWithImpl<$Res>
    implements _$$_EncapsuleSheetCopyWith<$Res> {
  __$$_EncapsuleSheetCopyWithImpl(
      _$_EncapsuleSheet _value, $Res Function(_$_EncapsuleSheet) _then)
      : super(_value, (v) => _then(v as _$_EncapsuleSheet));

  @override
  _$_EncapsuleSheet get _value => super._value as _$_EncapsuleSheet;

  @override
  $Res call({
    Object? tag = freezed,
    Object? builder = freezed,
    Object? containerBuilder = freezed,
    Object? onDismissed = freezed,
    Object? dismissible = freezed,
  }) {
    return _then(_$_EncapsuleSheet(
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as EncapsuleSheetBuilder,
      containerBuilder: containerBuilder == freezed
          ? _value.containerBuilder
          : containerBuilder // ignore: cast_nullable_to_non_nullable
              as EncapsuleSheetContainerBuilder?,
      onDismissed: onDismissed == freezed
          ? _value.onDismissed
          : onDismissed // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      dismissible: dismissible == freezed
          ? _value.dismissible
          : dismissible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EncapsuleSheet extends _EncapsuleSheet {
  _$_EncapsuleSheet(
      {this.tag,
      required this.builder,
      this.containerBuilder,
      this.onDismissed,
      this.dismissible = true})
      : super._();

  /// Tag to differentiate multiple active notifications.
  @override
  final String? tag;

  /// Sheet body builder.
  @override
  final EncapsuleSheetBuilder builder;

  /// Sheet body's container builder.
  @override
  final EncapsuleSheetContainerBuilder? containerBuilder;

  /// Callback on dismiss.
  @override
  final VoidCallback? onDismissed;

  /// Wether the user is allowed to manually dismiss this notification.
  @override
  @JsonKey()
  final bool dismissible;

  @override
  String toString() {
    return 'EncapsuleSheet(tag: $tag, builder: $builder, containerBuilder: $containerBuilder, onDismissed: $onDismissed, dismissible: $dismissible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncapsuleSheet &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            (identical(other.builder, builder) || other.builder == builder) &&
            (identical(other.containerBuilder, containerBuilder) ||
                other.containerBuilder == containerBuilder) &&
            (identical(other.onDismissed, onDismissed) ||
                other.onDismissed == onDismissed) &&
            const DeepCollectionEquality()
                .equals(other.dismissible, dismissible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tag),
      builder,
      containerBuilder,
      onDismissed,
      const DeepCollectionEquality().hash(dismissible));

  @JsonKey(ignore: true)
  @override
  _$$_EncapsuleSheetCopyWith<_$_EncapsuleSheet> get copyWith =>
      __$$_EncapsuleSheetCopyWithImpl<_$_EncapsuleSheet>(this, _$identity);
}

abstract class _EncapsuleSheet extends EncapsuleSheet {
  factory _EncapsuleSheet(
      {final String? tag,
      required final EncapsuleSheetBuilder builder,
      final EncapsuleSheetContainerBuilder? containerBuilder,
      final VoidCallback? onDismissed,
      final bool dismissible}) = _$_EncapsuleSheet;
  _EncapsuleSheet._() : super._();

  @override

  /// Tag to differentiate multiple active notifications.
  String? get tag => throw _privateConstructorUsedError;
  @override

  /// Sheet body builder.
  EncapsuleSheetBuilder get builder => throw _privateConstructorUsedError;
  @override

  /// Sheet body's container builder.
  EncapsuleSheetContainerBuilder? get containerBuilder =>
      throw _privateConstructorUsedError;
  @override

  /// Callback on dismiss.
  VoidCallback? get onDismissed => throw _privateConstructorUsedError;
  @override

  /// Wether the user is allowed to manually dismiss this notification.
  bool get dismissible => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EncapsuleSheetCopyWith<_$_EncapsuleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}
