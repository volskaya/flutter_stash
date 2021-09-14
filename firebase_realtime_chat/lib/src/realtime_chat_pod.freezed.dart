// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'realtime_chat_pod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RealtimeChatValueTearOff {
  const _$RealtimeChatValueTearOff();

  _RealtimeChatPodValue<T, D> call<T extends RealtimeChatMessageImpl,
          D extends RealtimeChatParticipantImpl>(
      {required List<T> paginated,
      required List<T> subscribed,
      required List<T> pending,
      required DateTime createTime,
      bool ended = false,
      int page = 0}) {
    return _RealtimeChatPodValue<T, D>(
      paginated: paginated,
      subscribed: subscribed,
      pending: pending,
      createTime: createTime,
      ended: ended,
      page: page,
    );
  }
}

/// @nodoc
const $RealtimeChatValue = _$RealtimeChatValueTearOff();

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
abstract class _$RealtimeChatPodValueCopyWith<
    T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl,
    $Res> implements $RealtimeChatValueCopyWith<T, D, $Res> {
  factory _$RealtimeChatPodValueCopyWith(_RealtimeChatPodValue<T, D> value,
          $Res Function(_RealtimeChatPodValue<T, D>) then) =
      __$RealtimeChatPodValueCopyWithImpl<T, D, $Res>;
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
class __$RealtimeChatPodValueCopyWithImpl<
        T extends RealtimeChatMessageImpl,
        D extends RealtimeChatParticipantImpl,
        $Res> extends _$RealtimeChatValueCopyWithImpl<T, D, $Res>
    implements _$RealtimeChatPodValueCopyWith<T, D, $Res> {
  __$RealtimeChatPodValueCopyWithImpl(_RealtimeChatPodValue<T, D> _value,
      $Res Function(_RealtimeChatPodValue<T, D>) _then)
      : super(_value, (v) => _then(v as _RealtimeChatPodValue<T, D>));

  @override
  _RealtimeChatPodValue<T, D> get _value =>
      super._value as _RealtimeChatPodValue<T, D>;

  @override
  $Res call({
    Object? paginated = freezed,
    Object? subscribed = freezed,
    Object? pending = freezed,
    Object? createTime = freezed,
    Object? ended = freezed,
    Object? page = freezed,
  }) {
    return _then(_RealtimeChatPodValue<T, D>(
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

class _$_RealtimeChatPodValue<T extends RealtimeChatMessageImpl,
        D extends RealtimeChatParticipantImpl>
    extends _RealtimeChatPodValue<T, D> with DiagnosticableTreeMixin {
  const _$_RealtimeChatPodValue(
      {required this.paginated,
      required this.subscribed,
      required this.pending,
      required this.createTime,
      this.ended = false,
      this.page = 0})
      : super._();

  @override
  final List<T> paginated;
  @override
  final List<T> subscribed;
  @override
  final List<T> pending;
  @override
  final DateTime createTime;
  @JsonKey(defaultValue: false)
  @override
  final bool ended;
  @JsonKey(defaultValue: 0)
  @override
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
        (other is _RealtimeChatPodValue<T, D> &&
            (identical(other.paginated, paginated) ||
                const DeepCollectionEquality()
                    .equals(other.paginated, paginated)) &&
            (identical(other.subscribed, subscribed) ||
                const DeepCollectionEquality()
                    .equals(other.subscribed, subscribed)) &&
            (identical(other.pending, pending) ||
                const DeepCollectionEquality()
                    .equals(other.pending, pending)) &&
            (identical(other.createTime, createTime) ||
                const DeepCollectionEquality()
                    .equals(other.createTime, createTime)) &&
            (identical(other.ended, ended) ||
                const DeepCollectionEquality().equals(other.ended, ended)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(paginated) ^
      const DeepCollectionEquality().hash(subscribed) ^
      const DeepCollectionEquality().hash(pending) ^
      const DeepCollectionEquality().hash(createTime) ^
      const DeepCollectionEquality().hash(ended) ^
      const DeepCollectionEquality().hash(page);

  @JsonKey(ignore: true)
  @override
  _$RealtimeChatPodValueCopyWith<T, D, _RealtimeChatPodValue<T, D>>
      get copyWith => __$RealtimeChatPodValueCopyWithImpl<T, D,
          _RealtimeChatPodValue<T, D>>(this, _$identity);
}

abstract class _RealtimeChatPodValue<T extends RealtimeChatMessageImpl,
    D extends RealtimeChatParticipantImpl> extends RealtimeChatValue<T, D> {
  const factory _RealtimeChatPodValue(
      {required List<T> paginated,
      required List<T> subscribed,
      required List<T> pending,
      required DateTime createTime,
      bool ended,
      int page}) = _$_RealtimeChatPodValue<T, D>;
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
  _$RealtimeChatPodValueCopyWith<T, D, _RealtimeChatPodValue<T, D>>
      get copyWith => throw _privateConstructorUsedError;
}
