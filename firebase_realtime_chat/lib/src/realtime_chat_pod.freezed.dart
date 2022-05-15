// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'realtime_chat_pod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RealtimeChatValue<T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl> {
  List<T> get paginated => throw _privateConstructorUsedError;
  List<T> get subscribed => throw _privateConstructorUsedError;
  List<T> get pending => throw _privateConstructorUsedError;
  DateTime get createTime => throw _privateConstructorUsedError;
  bool get ended => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RealtimeChatValueCopyWith<T, D, RealtimeChatValue<T, D>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealtimeChatValueCopyWith<T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl, $Res> {
  factory $RealtimeChatValueCopyWith(RealtimeChatValue<T, D> value,
          $Res Function(RealtimeChatValue<T, D>) then) =
      _$RealtimeChatValueCopyWithImpl<T, D, $Res>;
  $Res call(
      {List<T> paginated,
      List<T> subscribed,
      List<T> pending,
      DateTime createTime,
      bool ended,
      int page});
}

/// @nodoc
class _$RealtimeChatValueCopyWithImpl<
    T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl,
    $Res> implements $RealtimeChatValueCopyWith<T, D, $Res> {
  _$RealtimeChatValueCopyWithImpl(this._value, this._then);

  final RealtimeChatValue<T, D> _value;
  // ignore: unused_field
  final $Res Function(RealtimeChatValue<T, D>) _then;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? pending = freezed,
    Object? createTime = freezed,
    Object? ended = freezed,
    Object? page = freezed,
  }) {
    return _then(_value.copyWith(
      paginated: paginated == freezed
          ? _value.paginated
          : paginated // ignore: cast_nullable_to_non_nullable
              as List<T>,
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as List<T>,
      pending: pending == freezed
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as List<T>,
      createTime: createTime == freezed
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ended: ended == freezed
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as bool,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_RealtimeChatPodValueCopyWith<
    T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl,
    $Res> implements $RealtimeChatValueCopyWith<T, D, $Res> {
  factory _$$_RealtimeChatPodValueCopyWith(_$_RealtimeChatPodValue<T, D> value,
          $Res Function(_$_RealtimeChatPodValue<T, D>) then) =
      __$$_RealtimeChatPodValueCopyWithImpl<T, D, $Res>;
  @override
  $Res call(
      {List<T> paginated,
      List<T> subscribed,
      List<T> pending,
      DateTime createTime,
      bool ended,
      int page});
}

/// @nodoc
class __$$_RealtimeChatPodValueCopyWithImpl<
        T extends RealtimeChatMessageImpl,
        D extends RealtimeChatParticipantImpl,
        $Res> extends _$RealtimeChatValueCopyWithImpl<T, D, $Res>
    implements _$$_RealtimeChatPodValueCopyWith<T, D, $Res> {
  __$$_RealtimeChatPodValueCopyWithImpl(_$_RealtimeChatPodValue<T, D> _value,
      $Res Function(_$_RealtimeChatPodValue<T, D>) _then)
      : super(_value, (v) => _then(v as _$_RealtimeChatPodValue<T, D>));

  @override
  _$_RealtimeChatPodValue<T, D> get _value =>
      super._value as _$_RealtimeChatPodValue<T, D>;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? pending = freezed,
    Object? createTime = freezed,
    Object? ended = freezed,
    Object? page = freezed,
  }) {
    return _then(_$_RealtimeChatPodValue<T, D>(
      paginated: paginated == freezed
          ? _value._paginated
          : paginated // ignore: cast_nullable_to_non_nullable
              as List<T>,
      subscribed: subscribed == freezed
          ? _value._subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as List<T>,
      pending: pending == freezed
          ? _value._pending
          : pending // ignore: cast_nullable_to_non_nullable
              as List<T>,
      createTime: createTime == freezed
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ended: ended == freezed
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as bool,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RealtimeChatPodValue<T extends RealtimeChatMessageImpl,
        D extends RealtimeChatParticipantImpl>
    extends _RealtimeChatPodValue<T, D> with DiagnosticableTreeMixin {
  const _$_RealtimeChatPodValue(
      {required final List<T> paginated,
      required final List<T> subscribed,
      required final List<T> pending,
      required this.createTime,
      this.ended = false,
      this.page = 0})
      : _paginated = paginated,
        _subscribed = subscribed,
        _pending = pending,
        super._();

  final List<T> _paginated;
  @override
  List<T> get paginated {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paginated);
  }

  final List<T> _subscribed;
  @override
  List<T> get subscribed {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscribed);
  }

  final List<T> _pending;
  @override
  List<T> get pending {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pending);
  }

  @override
  final DateTime createTime;
  @override
  @JsonKey()
  final bool ended;
  @override
  @JsonKey()
  final int page;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RealtimeChatValue<$T, $D>(paginated: $paginated, subscribed: $subscribed, pending: $pending, createTime: $createTime, ended: $ended, page: $page)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RealtimeChatValue<$T, $D>'))
      ..add(DiagnosticsProperty('paginated', paginated))
      ..add(DiagnosticsProperty('subscribed', subscribed))
      ..add(DiagnosticsProperty('pending', pending))
      ..add(DiagnosticsProperty('createTime', createTime))
      ..add(DiagnosticsProperty('ended', ended))
      ..add(DiagnosticsProperty('page', page));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RealtimeChatPodValue<T, D> &&
            const DeepCollectionEquality()
                .equals(other._paginated, _paginated) &&
            const DeepCollectionEquality()
                .equals(other._subscribed, _subscribed) &&
            const DeepCollectionEquality().equals(other._pending, _pending) &&
            const DeepCollectionEquality()
                .equals(other.createTime, createTime) &&
            const DeepCollectionEquality().equals(other.ended, ended) &&
            const DeepCollectionEquality().equals(other.page, page));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_paginated),
      const DeepCollectionEquality().hash(_subscribed),
      const DeepCollectionEquality().hash(_pending),
      const DeepCollectionEquality().hash(createTime),
      const DeepCollectionEquality().hash(ended),
      const DeepCollectionEquality().hash(page));

  @JsonKey(ignore: true)
  @override
  _$$_RealtimeChatPodValueCopyWith<T, D, _$_RealtimeChatPodValue<T, D>>
      get copyWith => __$$_RealtimeChatPodValueCopyWithImpl<T, D,
          _$_RealtimeChatPodValue<T, D>>(this, _$identity);
}

abstract class _RealtimeChatPodValue<T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl> extends RealtimeChatValue<T, D> {
  const factory _RealtimeChatPodValue(
      {required final List<T> paginated,
      required final List<T> subscribed,
      required final List<T> pending,
      required final DateTime createTime,
      final bool ended,
      final int page}) = _$_RealtimeChatPodValue<T, D>;
  const _RealtimeChatPodValue._() : super._();

  @override
  List<T> get paginated => throw _privateConstructorUsedError;
  @override
  List<T> get subscribed => throw _privateConstructorUsedError;
  @override
  List<T> get pending => throw _privateConstructorUsedError;
  @override
  DateTime get createTime => throw _privateConstructorUsedError;
  @override
  bool get ended => throw _privateConstructorUsedError;
  @override
  int get page => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RealtimeChatPodValueCopyWith<T, D, _$_RealtimeChatPodValue<T, D>>
      get copyWith => throw _privateConstructorUsedError;
}
