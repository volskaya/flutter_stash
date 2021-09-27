// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'generative_widget_coordinator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GenerativeWidgetCoordinatorAttachmentTearOff {
  const _$GenerativeWidgetCoordinatorAttachmentTearOff();

  _GenerativeWidgetCoordinatorAttachment call(
      {required int offset,
      required int spacing,
      required bool enabled,
      required Widget Function(int, int, CollectionAttachmentCoordinator?)
          builder}) {
    return _GenerativeWidgetCoordinatorAttachment(
      offset: offset,
      spacing: spacing,
      enabled: enabled,
      builder: builder,
    );
  }
}

/// @nodoc
const $GenerativeWidgetCoordinatorAttachment =
    _$GenerativeWidgetCoordinatorAttachmentTearOff();

/// @nodoc
mixin _$GenerativeWidgetCoordinatorAttachment {
  int get offset => throw _privateConstructorUsedError;
  int get spacing => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  Widget Function(int, int, CollectionAttachmentCoordinator?) get builder =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenerativeWidgetCoordinatorAttachmentCopyWith<
          GenerativeWidgetCoordinatorAttachment>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  factory $GenerativeWidgetCoordinatorAttachmentCopyWith(
          GenerativeWidgetCoordinatorAttachment value,
          $Res Function(GenerativeWidgetCoordinatorAttachment) then) =
      _$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>;
  $Res call(
      {int offset,
      int spacing,
      bool enabled,
      Widget Function(int, int, CollectionAttachmentCoordinator?) builder});
}

/// @nodoc
class _$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>
    implements $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  _$GenerativeWidgetCoordinatorAttachmentCopyWithImpl(this._value, this._then);

  final GenerativeWidgetCoordinatorAttachment _value;
  // ignore: unused_field
  final $Res Function(GenerativeWidgetCoordinatorAttachment) _then;

  @override
  $Res call({
    Object? offset = freezed,
    Object? spacing = freezed,
    Object? enabled = freezed,
    Object? builder = freezed,
  }) {
    return _then(_value.copyWith(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      spacing: spacing == freezed
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int, CollectionAttachmentCoordinator?),
    ));
  }
}

/// @nodoc
abstract class _$GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>
    implements $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  factory _$GenerativeWidgetCoordinatorAttachmentCopyWith(
          _GenerativeWidgetCoordinatorAttachment value,
          $Res Function(_GenerativeWidgetCoordinatorAttachment) then) =
      __$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {int offset,
      int spacing,
      bool enabled,
      Widget Function(int, int, CollectionAttachmentCoordinator?) builder});
}

/// @nodoc
class __$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>
    extends _$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>
    implements _$GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  __$GenerativeWidgetCoordinatorAttachmentCopyWithImpl(
      _GenerativeWidgetCoordinatorAttachment _value,
      $Res Function(_GenerativeWidgetCoordinatorAttachment) _then)
      : super(
            _value, (v) => _then(v as _GenerativeWidgetCoordinatorAttachment));

  @override
  _GenerativeWidgetCoordinatorAttachment get _value =>
      super._value as _GenerativeWidgetCoordinatorAttachment;

  @override
  $Res call({
    Object? offset = freezed,
    Object? spacing = freezed,
    Object? enabled = freezed,
    Object? builder = freezed,
  }) {
    return _then(_GenerativeWidgetCoordinatorAttachment(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      spacing: spacing == freezed
          ? _value.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int, CollectionAttachmentCoordinator?),
    ));
  }
}

/// @nodoc

class _$_GenerativeWidgetCoordinatorAttachment
    extends _GenerativeWidgetCoordinatorAttachment {
  const _$_GenerativeWidgetCoordinatorAttachment(
      {required this.offset,
      required this.spacing,
      required this.enabled,
      required this.builder})
      : super._();

  @override
  final int offset;
  @override
  final int spacing;
  @override
  final bool enabled;
  @override
  final Widget Function(int, int, CollectionAttachmentCoordinator?) builder;

  @override
  String toString() {
    return 'GenerativeWidgetCoordinatorAttachment(offset: $offset, spacing: $spacing, enabled: $enabled, builder: $builder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GenerativeWidgetCoordinatorAttachment &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.spacing, spacing) ||
                const DeepCollectionEquality()
                    .equals(other.spacing, spacing)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality()
                    .equals(other.enabled, enabled)) &&
            (identical(other.builder, builder) ||
                const DeepCollectionEquality().equals(other.builder, builder)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(offset) ^
      const DeepCollectionEquality().hash(spacing) ^
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(builder);

  @JsonKey(ignore: true)
  @override
  _$GenerativeWidgetCoordinatorAttachmentCopyWith<
          _GenerativeWidgetCoordinatorAttachment>
      get copyWith => __$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<
          _GenerativeWidgetCoordinatorAttachment>(this, _$identity);
}

abstract class _GenerativeWidgetCoordinatorAttachment
    extends GenerativeWidgetCoordinatorAttachment {
  const factory _GenerativeWidgetCoordinatorAttachment(
      {required int offset,
      required int spacing,
      required bool enabled,
      required Widget Function(int, int, CollectionAttachmentCoordinator?)
          builder}) = _$_GenerativeWidgetCoordinatorAttachment;
  const _GenerativeWidgetCoordinatorAttachment._() : super._();

  @override
  int get offset => throw _privateConstructorUsedError;
  @override
  int get spacing => throw _privateConstructorUsedError;
  @override
  bool get enabled => throw _privateConstructorUsedError;
  @override
  Widget Function(int, int, CollectionAttachmentCoordinator?) get builder =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GenerativeWidgetCoordinatorAttachmentCopyWith<
          _GenerativeWidgetCoordinatorAttachment>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$GenerativeWidgetCoordinatorBuildersTearOff {
  const _$GenerativeWidgetCoordinatorBuildersTearOff();

  _GenerativeWidgetCoordinatorBuilders call(
      {required Widget Function(int, int, CollectionAttachmentCoordinator?)
          paginated,
      Widget Function(int, int)? subscribed,
      GenerativeWidgetCoordinatorAttachment? attachment}) {
    return _GenerativeWidgetCoordinatorBuilders(
      paginated: paginated,
      subscribed: subscribed,
      attachment: attachment,
    );
  }
}

/// @nodoc
const $GenerativeWidgetCoordinatorBuilders =
    _$GenerativeWidgetCoordinatorBuildersTearOff();

/// @nodoc
mixin _$GenerativeWidgetCoordinatorBuilders {
  Widget Function(int, int, CollectionAttachmentCoordinator?) get paginated =>
      throw _privateConstructorUsedError;
  Widget Function(int, int)? get subscribed =>
      throw _privateConstructorUsedError;
  GenerativeWidgetCoordinatorAttachment? get attachment =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenerativeWidgetCoordinatorBuildersCopyWith<
          GenerativeWidgetCoordinatorBuilders>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  factory $GenerativeWidgetCoordinatorBuildersCopyWith(
          GenerativeWidgetCoordinatorBuilders value,
          $Res Function(GenerativeWidgetCoordinatorBuilders) then) =
      _$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>;
  $Res call(
      {Widget Function(int, int, CollectionAttachmentCoordinator?) paginated,
      Widget Function(int, int)? subscribed,
      GenerativeWidgetCoordinatorAttachment? attachment});

  $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>? get attachment;
}

/// @nodoc
class _$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>
    implements $GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  _$GenerativeWidgetCoordinatorBuildersCopyWithImpl(this._value, this._then);

  final GenerativeWidgetCoordinatorBuilders _value;
  // ignore: unused_field
  final $Res Function(GenerativeWidgetCoordinatorBuilders) _then;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_value.copyWith(
      paginated: paginated == freezed
          ? _value.paginated
          : paginated // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int, CollectionAttachmentCoordinator?),
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int)?,
      attachment: attachment == freezed
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as GenerativeWidgetCoordinatorAttachment?,
    ));
  }

  @override
  $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>? get attachment {
    if (_value.attachment == null) {
      return null;
    }

    return $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>(
        _value.attachment!, (value) {
      return _then(_value.copyWith(attachment: value));
    });
  }
}

/// @nodoc
abstract class _$GenerativeWidgetCoordinatorBuildersCopyWith<$Res>
    implements $GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  factory _$GenerativeWidgetCoordinatorBuildersCopyWith(
          _GenerativeWidgetCoordinatorBuilders value,
          $Res Function(_GenerativeWidgetCoordinatorBuilders) then) =
      __$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>;
  @override
  $Res call(
      {Widget Function(int, int, CollectionAttachmentCoordinator?) paginated,
      Widget Function(int, int)? subscribed,
      GenerativeWidgetCoordinatorAttachment? attachment});

  @override
  $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>? get attachment;
}

/// @nodoc
class __$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>
    extends _$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>
    implements _$GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  __$GenerativeWidgetCoordinatorBuildersCopyWithImpl(
      _GenerativeWidgetCoordinatorBuilders _value,
      $Res Function(_GenerativeWidgetCoordinatorBuilders) _then)
      : super(_value, (v) => _then(v as _GenerativeWidgetCoordinatorBuilders));

  @override
  _GenerativeWidgetCoordinatorBuilders get _value =>
      super._value as _GenerativeWidgetCoordinatorBuilders;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_GenerativeWidgetCoordinatorBuilders(
      paginated: paginated == freezed
          ? _value.paginated
          : paginated // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int, CollectionAttachmentCoordinator?),
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as Widget Function(int, int)?,
      attachment: attachment == freezed
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as GenerativeWidgetCoordinatorAttachment?,
    ));
  }
}

/// @nodoc

class _$_GenerativeWidgetCoordinatorBuilders
    implements _GenerativeWidgetCoordinatorBuilders {
  const _$_GenerativeWidgetCoordinatorBuilders(
      {required this.paginated, this.subscribed, this.attachment});

  @override
  final Widget Function(int, int, CollectionAttachmentCoordinator?) paginated;
  @override
  final Widget Function(int, int)? subscribed;
  @override
  final GenerativeWidgetCoordinatorAttachment? attachment;

  @override
  String toString() {
    return 'GenerativeWidgetCoordinatorBuilders(paginated: $paginated, subscribed: $subscribed, attachment: $attachment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GenerativeWidgetCoordinatorBuilders &&
            (identical(other.paginated, paginated) ||
                const DeepCollectionEquality()
                    .equals(other.paginated, paginated)) &&
            (identical(other.subscribed, subscribed) ||
                const DeepCollectionEquality()
                    .equals(other.subscribed, subscribed)) &&
            (identical(other.attachment, attachment) ||
                const DeepCollectionEquality()
                    .equals(other.attachment, attachment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(paginated) ^
      const DeepCollectionEquality().hash(subscribed) ^
      const DeepCollectionEquality().hash(attachment);

  @JsonKey(ignore: true)
  @override
  _$GenerativeWidgetCoordinatorBuildersCopyWith<
          _GenerativeWidgetCoordinatorBuilders>
      get copyWith => __$GenerativeWidgetCoordinatorBuildersCopyWithImpl<
          _GenerativeWidgetCoordinatorBuilders>(this, _$identity);
}

abstract class _GenerativeWidgetCoordinatorBuilders
    implements GenerativeWidgetCoordinatorBuilders {
  const factory _GenerativeWidgetCoordinatorBuilders(
          {required Widget Function(int, int, CollectionAttachmentCoordinator?)
              paginated,
          Widget Function(int, int)? subscribed,
          GenerativeWidgetCoordinatorAttachment? attachment}) =
      _$_GenerativeWidgetCoordinatorBuilders;

  @override
  Widget Function(int, int, CollectionAttachmentCoordinator?) get paginated =>
      throw _privateConstructorUsedError;
  @override
  Widget Function(int, int)? get subscribed =>
      throw _privateConstructorUsedError;
  @override
  GenerativeWidgetCoordinatorAttachment? get attachment =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GenerativeWidgetCoordinatorBuildersCopyWith<
          _GenerativeWidgetCoordinatorBuilders>
      get copyWith => throw _privateConstructorUsedError;
}
