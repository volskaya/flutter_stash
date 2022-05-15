// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'generative_widget_coordinator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GenerativeWidgetCoordinatorAttachment {
  int get offset => throw _privateConstructorUsedError;
  int get spacing => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  GenerativeWidgetCoordinatorPaginatedBuilder get builder =>
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
      GenerativeWidgetCoordinatorPaginatedBuilder builder});
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
              as GenerativeWidgetCoordinatorPaginatedBuilder,
    ));
  }
}

/// @nodoc
abstract class _$$_GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>
    implements $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  factory _$$_GenerativeWidgetCoordinatorAttachmentCopyWith(
          _$_GenerativeWidgetCoordinatorAttachment value,
          $Res Function(_$_GenerativeWidgetCoordinatorAttachment) then) =
      __$$_GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {int offset,
      int spacing,
      bool enabled,
      GenerativeWidgetCoordinatorPaginatedBuilder builder});
}

/// @nodoc
class __$$_GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>
    extends _$GenerativeWidgetCoordinatorAttachmentCopyWithImpl<$Res>
    implements _$$_GenerativeWidgetCoordinatorAttachmentCopyWith<$Res> {
  __$$_GenerativeWidgetCoordinatorAttachmentCopyWithImpl(
      _$_GenerativeWidgetCoordinatorAttachment _value,
      $Res Function(_$_GenerativeWidgetCoordinatorAttachment) _then)
      : super(_value,
            (v) => _then(v as _$_GenerativeWidgetCoordinatorAttachment));

  @override
  _$_GenerativeWidgetCoordinatorAttachment get _value =>
      super._value as _$_GenerativeWidgetCoordinatorAttachment;

  @override
  $Res call({
    Object? offset = freezed,
    Object? spacing = freezed,
    Object? enabled = freezed,
    Object? builder = freezed,
  }) {
    return _then(_$_GenerativeWidgetCoordinatorAttachment(
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
              as GenerativeWidgetCoordinatorPaginatedBuilder,
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
  final GenerativeWidgetCoordinatorPaginatedBuilder builder;

  @override
  String toString() {
    return 'GenerativeWidgetCoordinatorAttachment(offset: $offset, spacing: $spacing, enabled: $enabled, builder: $builder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerativeWidgetCoordinatorAttachment &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.spacing, spacing) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            (identical(other.builder, builder) || other.builder == builder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(spacing),
      const DeepCollectionEquality().hash(enabled),
      builder);

  @JsonKey(ignore: true)
  @override
  _$$_GenerativeWidgetCoordinatorAttachmentCopyWith<
          _$_GenerativeWidgetCoordinatorAttachment>
      get copyWith => __$$_GenerativeWidgetCoordinatorAttachmentCopyWithImpl<
          _$_GenerativeWidgetCoordinatorAttachment>(this, _$identity);
}

abstract class _GenerativeWidgetCoordinatorAttachment
    extends GenerativeWidgetCoordinatorAttachment {
  const factory _GenerativeWidgetCoordinatorAttachment(
          {required final int offset,
          required final int spacing,
          required final bool enabled,
          required final GenerativeWidgetCoordinatorPaginatedBuilder builder}) =
      _$_GenerativeWidgetCoordinatorAttachment;
  const _GenerativeWidgetCoordinatorAttachment._() : super._();

  @override
  int get offset => throw _privateConstructorUsedError;
  @override
  int get spacing => throw _privateConstructorUsedError;
  @override
  bool get enabled => throw _privateConstructorUsedError;
  @override
  GenerativeWidgetCoordinatorPaginatedBuilder get builder =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GenerativeWidgetCoordinatorAttachmentCopyWith<
          _$_GenerativeWidgetCoordinatorAttachment>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GenerativeWidgetCoordinatorBuilders {
  GenerativeWidgetCoordinatorPaginatedBuilder get paginated =>
      throw _privateConstructorUsedError;
  GenerativeWidgetCoordinatorSubscribedBuilder? get subscribed =>
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
      {GenerativeWidgetCoordinatorPaginatedBuilder paginated,
      GenerativeWidgetCoordinatorSubscribedBuilder? subscribed,
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
              as GenerativeWidgetCoordinatorPaginatedBuilder,
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as GenerativeWidgetCoordinatorSubscribedBuilder?,
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
abstract class _$$_GenerativeWidgetCoordinatorBuildersCopyWith<$Res>
    implements $GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  factory _$$_GenerativeWidgetCoordinatorBuildersCopyWith(
          _$_GenerativeWidgetCoordinatorBuilders value,
          $Res Function(_$_GenerativeWidgetCoordinatorBuilders) then) =
      __$$_GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>;
  @override
  $Res call(
      {GenerativeWidgetCoordinatorPaginatedBuilder paginated,
      GenerativeWidgetCoordinatorSubscribedBuilder? subscribed,
      GenerativeWidgetCoordinatorAttachment? attachment});

  @override
  $GenerativeWidgetCoordinatorAttachmentCopyWith<$Res>? get attachment;
}

/// @nodoc
class __$$_GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>
    extends _$GenerativeWidgetCoordinatorBuildersCopyWithImpl<$Res>
    implements _$$_GenerativeWidgetCoordinatorBuildersCopyWith<$Res> {
  __$$_GenerativeWidgetCoordinatorBuildersCopyWithImpl(
      _$_GenerativeWidgetCoordinatorBuilders _value,
      $Res Function(_$_GenerativeWidgetCoordinatorBuilders) _then)
      : super(
            _value, (v) => _then(v as _$_GenerativeWidgetCoordinatorBuilders));

  @override
  _$_GenerativeWidgetCoordinatorBuilders get _value =>
      super._value as _$_GenerativeWidgetCoordinatorBuilders;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_$_GenerativeWidgetCoordinatorBuilders(
      paginated: paginated == freezed
          ? _value.paginated
          : paginated // ignore: cast_nullable_to_non_nullable
              as GenerativeWidgetCoordinatorPaginatedBuilder,
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as GenerativeWidgetCoordinatorSubscribedBuilder?,
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
  final GenerativeWidgetCoordinatorPaginatedBuilder paginated;
  @override
  final GenerativeWidgetCoordinatorSubscribedBuilder? subscribed;
  @override
  final GenerativeWidgetCoordinatorAttachment? attachment;

  @override
  String toString() {
    return 'GenerativeWidgetCoordinatorBuilders(paginated: $paginated, subscribed: $subscribed, attachment: $attachment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GenerativeWidgetCoordinatorBuilders &&
            (identical(other.paginated, paginated) ||
                other.paginated == paginated) &&
            (identical(other.subscribed, subscribed) ||
                other.subscribed == subscribed) &&
            const DeepCollectionEquality()
                .equals(other.attachment, attachment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paginated, subscribed,
      const DeepCollectionEquality().hash(attachment));

  @JsonKey(ignore: true)
  @override
  _$$_GenerativeWidgetCoordinatorBuildersCopyWith<
          _$_GenerativeWidgetCoordinatorBuilders>
      get copyWith => __$$_GenerativeWidgetCoordinatorBuildersCopyWithImpl<
          _$_GenerativeWidgetCoordinatorBuilders>(this, _$identity);
}

abstract class _GenerativeWidgetCoordinatorBuilders
    implements GenerativeWidgetCoordinatorBuilders {
  const factory _GenerativeWidgetCoordinatorBuilders(
          {required final GenerativeWidgetCoordinatorPaginatedBuilder paginated,
          final GenerativeWidgetCoordinatorSubscribedBuilder? subscribed,
          final GenerativeWidgetCoordinatorAttachment? attachment}) =
      _$_GenerativeWidgetCoordinatorBuilders;

  @override
  GenerativeWidgetCoordinatorPaginatedBuilder get paginated =>
      throw _privateConstructorUsedError;
  @override
  GenerativeWidgetCoordinatorSubscribedBuilder? get subscribed =>
      throw _privateConstructorUsedError;
  @override
  GenerativeWidgetCoordinatorAttachment? get attachment =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GenerativeWidgetCoordinatorBuildersCopyWith<
          _$_GenerativeWidgetCoordinatorBuilders>
      get copyWith => throw _privateConstructorUsedError;
}
