// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BlobDataTearOff {
  const _$BlobDataTearOff();

  _BlobData call(
      {required Size size,
      required BlobPoints points,
      required Path path,
      required BlobCurves curves,
      required BlobSeed seed}) {
    return _BlobData(
      size: size,
      points: points,
      path: path,
      curves: curves,
      seed: seed,
    );
  }
}

/// @nodoc
const $BlobData = _$BlobDataTearOff();

/// @nodoc
mixin _$BlobData {
  Size get size => throw _privateConstructorUsedError;
  BlobPoints get points => throw _privateConstructorUsedError;
  Path get path => throw _privateConstructorUsedError;
  BlobCurves get curves => throw _privateConstructorUsedError;
  BlobSeed get seed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobDataCopyWith<BlobData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobDataCopyWith<$Res> {
  factory $BlobDataCopyWith(BlobData value, $Res Function(BlobData) then) =
      _$BlobDataCopyWithImpl<$Res>;
  $Res call(
      {Size size,
      BlobPoints points,
      Path path,
      BlobCurves curves,
      BlobSeed seed});

  $BlobPointsCopyWith<$Res> get points;
  $BlobCurvesCopyWith<$Res> get curves;
  $BlobSeedCopyWith<$Res> get seed;
}

/// @nodoc
class _$BlobDataCopyWithImpl<$Res> implements $BlobDataCopyWith<$Res> {
  _$BlobDataCopyWithImpl(this._value, this._then);

  final BlobData _value;
  // ignore: unused_field
  final $Res Function(BlobData) _then;

  @override
  $Res call({
    Object? size = freezed,
    Object? points = freezed,
    Object? path = freezed,
    Object? curves = freezed,
    Object? seed = freezed,
  }) {
    return _then(_value.copyWith(
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as BlobPoints,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as Path,
      curves: curves == freezed
          ? _value.curves
          : curves // ignore: cast_nullable_to_non_nullable
              as BlobCurves,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed,
    ));
  }

  @override
  $BlobPointsCopyWith<$Res> get points {
    return $BlobPointsCopyWith<$Res>(_value.points, (value) {
      return _then(_value.copyWith(points: value));
    });
  }

  @override
  $BlobCurvesCopyWith<$Res> get curves {
    return $BlobCurvesCopyWith<$Res>(_value.curves, (value) {
      return _then(_value.copyWith(curves: value));
    });
  }

  @override
  $BlobSeedCopyWith<$Res> get seed {
    return $BlobSeedCopyWith<$Res>(_value.seed, (value) {
      return _then(_value.copyWith(seed: value));
    });
  }
}

/// @nodoc
abstract class _$BlobDataCopyWith<$Res> implements $BlobDataCopyWith<$Res> {
  factory _$BlobDataCopyWith(_BlobData value, $Res Function(_BlobData) then) =
      __$BlobDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Size size,
      BlobPoints points,
      Path path,
      BlobCurves curves,
      BlobSeed seed});

  @override
  $BlobPointsCopyWith<$Res> get points;
  @override
  $BlobCurvesCopyWith<$Res> get curves;
  @override
  $BlobSeedCopyWith<$Res> get seed;
}

/// @nodoc
class __$BlobDataCopyWithImpl<$Res> extends _$BlobDataCopyWithImpl<$Res>
    implements _$BlobDataCopyWith<$Res> {
  __$BlobDataCopyWithImpl(_BlobData _value, $Res Function(_BlobData) _then)
      : super(_value, (v) => _then(v as _BlobData));

  @override
  _BlobData get _value => super._value as _BlobData;

  @override
  $Res call({
    Object? size = freezed,
    Object? points = freezed,
    Object? path = freezed,
    Object? curves = freezed,
    Object? seed = freezed,
  }) {
    return _then(_BlobData(
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as BlobPoints,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as Path,
      curves: curves == freezed
          ? _value.curves
          : curves // ignore: cast_nullable_to_non_nullable
              as BlobCurves,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed,
    ));
  }
}

/// @nodoc

class _$_BlobData implements _BlobData {
  const _$_BlobData(
      {required this.size,
      required this.points,
      required this.path,
      required this.curves,
      required this.seed});

  @override
  final Size size;
  @override
  final BlobPoints points;
  @override
  final Path path;
  @override
  final BlobCurves curves;
  @override
  final BlobSeed seed;

  @override
  String toString() {
    return 'BlobData(size: $size, points: $points, path: $path, curves: $curves, seed: $seed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobData &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.curves, curves) ||
                const DeepCollectionEquality().equals(other.curves, curves)) &&
            (identical(other.seed, seed) ||
                const DeepCollectionEquality().equals(other.seed, seed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(curves) ^
      const DeepCollectionEquality().hash(seed);

  @JsonKey(ignore: true)
  @override
  _$BlobDataCopyWith<_BlobData> get copyWith =>
      __$BlobDataCopyWithImpl<_BlobData>(this, _$identity);
}

abstract class _BlobData implements BlobData {
  const factory _BlobData(
      {required Size size,
      required BlobPoints points,
      required Path path,
      required BlobCurves curves,
      required BlobSeed seed}) = _$_BlobData;

  @override
  Size get size => throw _privateConstructorUsedError;
  @override
  BlobPoints get points => throw _privateConstructorUsedError;
  @override
  Path get path => throw _privateConstructorUsedError;
  @override
  BlobCurves get curves => throw _privateConstructorUsedError;
  @override
  BlobSeed get seed => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobDataCopyWith<_BlobData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BlobSeedTearOff {
  const _$BlobSeedTearOff();

  _BlobSeed call(int rand,
      [int edges = BlobConfig.edgesCount, int growth = BlobConfig.minGrowth]) {
    return _BlobSeed(
      rand,
      edges,
      growth,
    );
  }
}

/// @nodoc
const $BlobSeed = _$BlobSeedTearOff();

/// @nodoc
mixin _$BlobSeed {
  int get rand => throw _privateConstructorUsedError;
  int get edges => throw _privateConstructorUsedError;
  int get growth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobSeedCopyWith<BlobSeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobSeedCopyWith<$Res> {
  factory $BlobSeedCopyWith(BlobSeed value, $Res Function(BlobSeed) then) =
      _$BlobSeedCopyWithImpl<$Res>;
  $Res call({int rand, int edges, int growth});
}

/// @nodoc
class _$BlobSeedCopyWithImpl<$Res> implements $BlobSeedCopyWith<$Res> {
  _$BlobSeedCopyWithImpl(this._value, this._then);

  final BlobSeed _value;
  // ignore: unused_field
  final $Res Function(BlobSeed) _then;

  @override
  $Res call({
    Object? rand = freezed,
    Object? edges = freezed,
    Object? growth = freezed,
  }) {
    return _then(_value.copyWith(
      rand: rand == freezed
          ? _value.rand
          : rand // ignore: cast_nullable_to_non_nullable
              as int,
      edges: edges == freezed
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as int,
      growth: growth == freezed
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$BlobSeedCopyWith<$Res> implements $BlobSeedCopyWith<$Res> {
  factory _$BlobSeedCopyWith(_BlobSeed value, $Res Function(_BlobSeed) then) =
      __$BlobSeedCopyWithImpl<$Res>;
  @override
  $Res call({int rand, int edges, int growth});
}

/// @nodoc
class __$BlobSeedCopyWithImpl<$Res> extends _$BlobSeedCopyWithImpl<$Res>
    implements _$BlobSeedCopyWith<$Res> {
  __$BlobSeedCopyWithImpl(_BlobSeed _value, $Res Function(_BlobSeed) _then)
      : super(_value, (v) => _then(v as _BlobSeed));

  @override
  _BlobSeed get _value => super._value as _BlobSeed;

  @override
  $Res call({
    Object? rand = freezed,
    Object? edges = freezed,
    Object? growth = freezed,
  }) {
    return _then(_BlobSeed(
      rand == freezed
          ? _value.rand
          : rand // ignore: cast_nullable_to_non_nullable
              as int,
      edges == freezed
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as int,
      growth == freezed
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_BlobSeed implements _BlobSeed {
  const _$_BlobSeed(this.rand,
      [this.edges = BlobConfig.edgesCount, this.growth = BlobConfig.minGrowth])
      : assert(edges >= 2 && edges <= 300),
        assert(growth >= 2 && growth <= 9);

  @override
  final int rand;
  @JsonKey(defaultValue: BlobConfig.edgesCount)
  @override
  final int edges;
  @JsonKey(defaultValue: BlobConfig.minGrowth)
  @override
  final int growth;

  @override
  String toString() {
    return 'BlobSeed(rand: $rand, edges: $edges, growth: $growth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobSeed &&
            (identical(other.rand, rand) ||
                const DeepCollectionEquality().equals(other.rand, rand)) &&
            (identical(other.edges, edges) ||
                const DeepCollectionEquality().equals(other.edges, edges)) &&
            (identical(other.growth, growth) ||
                const DeepCollectionEquality().equals(other.growth, growth)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(rand) ^
      const DeepCollectionEquality().hash(edges) ^
      const DeepCollectionEquality().hash(growth);

  @JsonKey(ignore: true)
  @override
  _$BlobSeedCopyWith<_BlobSeed> get copyWith =>
      __$BlobSeedCopyWithImpl<_BlobSeed>(this, _$identity);
}

abstract class _BlobSeed implements BlobSeed {
  const factory _BlobSeed(int rand, [int edges, int growth]) = _$_BlobSeed;

  @override
  int get rand => throw _privateConstructorUsedError;
  @override
  int get edges => throw _privateConstructorUsedError;
  @override
  int get growth => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobSeedCopyWith<_BlobSeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BlobCurvesTearOff {
  const _$BlobCurvesTearOff();

  _BlobCurves call(
      {required Offset start,
      required List<List<double>> curves,
      required List<Offset> breakpoints}) {
    return _BlobCurves(
      start: start,
      curves: curves,
      breakpoints: breakpoints,
    );
  }
}

/// @nodoc
const $BlobCurves = _$BlobCurvesTearOff();

/// @nodoc
mixin _$BlobCurves {
  Offset get start => throw _privateConstructorUsedError;
  List<List<double>> get curves => throw _privateConstructorUsedError;
  List<Offset> get breakpoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobCurvesCopyWith<BlobCurves> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobCurvesCopyWith<$Res> {
  factory $BlobCurvesCopyWith(
          BlobCurves value, $Res Function(BlobCurves) then) =
      _$BlobCurvesCopyWithImpl<$Res>;
  $Res call(
      {Offset start, List<List<double>> curves, List<Offset> breakpoints});
}

/// @nodoc
class _$BlobCurvesCopyWithImpl<$Res> implements $BlobCurvesCopyWith<$Res> {
  _$BlobCurvesCopyWithImpl(this._value, this._then);

  final BlobCurves _value;
  // ignore: unused_field
  final $Res Function(BlobCurves) _then;

  @override
  $Res call({
    Object? start = freezed,
    Object? curves = freezed,
    Object? breakpoints = freezed,
  }) {
    return _then(_value.copyWith(
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Offset,
      curves: curves == freezed
          ? _value.curves
          : curves // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      breakpoints: breakpoints == freezed
          ? _value.breakpoints
          : breakpoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
    ));
  }
}

/// @nodoc
abstract class _$BlobCurvesCopyWith<$Res> implements $BlobCurvesCopyWith<$Res> {
  factory _$BlobCurvesCopyWith(
          _BlobCurves value, $Res Function(_BlobCurves) then) =
      __$BlobCurvesCopyWithImpl<$Res>;
  @override
  $Res call(
      {Offset start, List<List<double>> curves, List<Offset> breakpoints});
}

/// @nodoc
class __$BlobCurvesCopyWithImpl<$Res> extends _$BlobCurvesCopyWithImpl<$Res>
    implements _$BlobCurvesCopyWith<$Res> {
  __$BlobCurvesCopyWithImpl(
      _BlobCurves _value, $Res Function(_BlobCurves) _then)
      : super(_value, (v) => _then(v as _BlobCurves));

  @override
  _BlobCurves get _value => super._value as _BlobCurves;

  @override
  $Res call({
    Object? start = freezed,
    Object? curves = freezed,
    Object? breakpoints = freezed,
  }) {
    return _then(_BlobCurves(
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Offset,
      curves: curves == freezed
          ? _value.curves
          : curves // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      breakpoints: breakpoints == freezed
          ? _value.breakpoints
          : breakpoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
    ));
  }
}

/// @nodoc

class _$_BlobCurves implements _BlobCurves {
  const _$_BlobCurves(
      {required this.start, required this.curves, required this.breakpoints});

  @override
  final Offset start;
  @override
  final List<List<double>> curves;
  @override
  final List<Offset> breakpoints;

  @override
  String toString() {
    return 'BlobCurves(start: $start, curves: $curves, breakpoints: $breakpoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobCurves &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.curves, curves) ||
                const DeepCollectionEquality().equals(other.curves, curves)) &&
            (identical(other.breakpoints, breakpoints) ||
                const DeepCollectionEquality()
                    .equals(other.breakpoints, breakpoints)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(curves) ^
      const DeepCollectionEquality().hash(breakpoints);

  @JsonKey(ignore: true)
  @override
  _$BlobCurvesCopyWith<_BlobCurves> get copyWith =>
      __$BlobCurvesCopyWithImpl<_BlobCurves>(this, _$identity);
}

abstract class _BlobCurves implements BlobCurves {
  const factory _BlobCurves(
      {required Offset start,
      required List<List<double>> curves,
      required List<Offset> breakpoints}) = _$_BlobCurves;

  @override
  Offset get start => throw _privateConstructorUsedError;
  @override
  List<List<double>> get curves => throw _privateConstructorUsedError;
  @override
  List<Offset> get breakpoints => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobCurvesCopyWith<_BlobCurves> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BlobStyleTearOff {
  const _$BlobStyleTearOff();

  _BlobStyle call(
      {Color color = BlobConfig.color,
      double strokeWidth = BlobConfig.strokeWidth,
      PaintingStyle fillType = BlobConfig.fillType,
      Shader? gradient}) {
    return _BlobStyle(
      color: color,
      strokeWidth: strokeWidth,
      fillType: fillType,
      gradient: gradient,
    );
  }
}

/// @nodoc
const $BlobStyle = _$BlobStyleTearOff();

/// @nodoc
mixin _$BlobStyle {
  Color get color => throw _privateConstructorUsedError;
  double get strokeWidth => throw _privateConstructorUsedError;
  PaintingStyle get fillType => throw _privateConstructorUsedError;
  Shader? get gradient => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobStyleCopyWith<BlobStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobStyleCopyWith<$Res> {
  factory $BlobStyleCopyWith(BlobStyle value, $Res Function(BlobStyle) then) =
      _$BlobStyleCopyWithImpl<$Res>;
  $Res call(
      {Color color,
      double strokeWidth,
      PaintingStyle fillType,
      Shader? gradient});
}

/// @nodoc
class _$BlobStyleCopyWithImpl<$Res> implements $BlobStyleCopyWith<$Res> {
  _$BlobStyleCopyWithImpl(this._value, this._then);

  final BlobStyle _value;
  // ignore: unused_field
  final $Res Function(BlobStyle) _then;

  @override
  $Res call({
    Object? color = freezed,
    Object? strokeWidth = freezed,
    Object? fillType = freezed,
    Object? gradient = freezed,
  }) {
    return _then(_value.copyWith(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      fillType: fillType == freezed
          ? _value.fillType
          : fillType // ignore: cast_nullable_to_non_nullable
              as PaintingStyle,
      gradient: gradient == freezed
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as Shader?,
    ));
  }
}

/// @nodoc
abstract class _$BlobStyleCopyWith<$Res> implements $BlobStyleCopyWith<$Res> {
  factory _$BlobStyleCopyWith(
          _BlobStyle value, $Res Function(_BlobStyle) then) =
      __$BlobStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color color,
      double strokeWidth,
      PaintingStyle fillType,
      Shader? gradient});
}

/// @nodoc
class __$BlobStyleCopyWithImpl<$Res> extends _$BlobStyleCopyWithImpl<$Res>
    implements _$BlobStyleCopyWith<$Res> {
  __$BlobStyleCopyWithImpl(_BlobStyle _value, $Res Function(_BlobStyle) _then)
      : super(_value, (v) => _then(v as _BlobStyle));

  @override
  _BlobStyle get _value => super._value as _BlobStyle;

  @override
  $Res call({
    Object? color = freezed,
    Object? strokeWidth = freezed,
    Object? fillType = freezed,
    Object? gradient = freezed,
  }) {
    return _then(_BlobStyle(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      fillType: fillType == freezed
          ? _value.fillType
          : fillType // ignore: cast_nullable_to_non_nullable
              as PaintingStyle,
      gradient: gradient == freezed
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as Shader?,
    ));
  }
}

/// @nodoc

class _$_BlobStyle extends _BlobStyle {
  _$_BlobStyle(
      {this.color = BlobConfig.color,
      this.strokeWidth = BlobConfig.strokeWidth,
      this.fillType = BlobConfig.fillType,
      this.gradient})
      : super._();

  @JsonKey(defaultValue: BlobConfig.color)
  @override
  final Color color;
  @JsonKey(defaultValue: BlobConfig.strokeWidth)
  @override
  final double strokeWidth;
  @JsonKey(defaultValue: BlobConfig.fillType)
  @override
  final PaintingStyle fillType;
  @override
  final Shader? gradient;

  @override
  String toString() {
    return 'BlobStyle(color: $color, strokeWidth: $strokeWidth, fillType: $fillType, gradient: $gradient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobStyle &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.strokeWidth, strokeWidth) ||
                const DeepCollectionEquality()
                    .equals(other.strokeWidth, strokeWidth)) &&
            (identical(other.fillType, fillType) ||
                const DeepCollectionEquality()
                    .equals(other.fillType, fillType)) &&
            (identical(other.gradient, gradient) ||
                const DeepCollectionEquality()
                    .equals(other.gradient, gradient)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(strokeWidth) ^
      const DeepCollectionEquality().hash(fillType) ^
      const DeepCollectionEquality().hash(gradient);

  @JsonKey(ignore: true)
  @override
  _$BlobStyleCopyWith<_BlobStyle> get copyWith =>
      __$BlobStyleCopyWithImpl<_BlobStyle>(this, _$identity);
}

abstract class _BlobStyle extends BlobStyle {
  factory _BlobStyle(
      {Color color,
      double strokeWidth,
      PaintingStyle fillType,
      Shader? gradient}) = _$_BlobStyle;
  _BlobStyle._() : super._();

  @override
  Color get color => throw _privateConstructorUsedError;
  @override
  double get strokeWidth => throw _privateConstructorUsedError;
  @override
  PaintingStyle get fillType => throw _privateConstructorUsedError;
  @override
  Shader? get gradient => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobStyleCopyWith<_BlobStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BlobPointsTearOff {
  const _$BlobPointsTearOff();

  _BlobPoints call(
      {required List<Offset> originPoints,
      required List<Offset> destPoints,
      required Offset center,
      required double innerRad,
      BlobSeed? seed}) {
    return _BlobPoints(
      originPoints: originPoints,
      destPoints: destPoints,
      center: center,
      innerRad: innerRad,
      seed: seed,
    );
  }
}

/// @nodoc
const $BlobPoints = _$BlobPointsTearOff();

/// @nodoc
mixin _$BlobPoints {
  List<Offset> get originPoints => throw _privateConstructorUsedError;
  List<Offset> get destPoints => throw _privateConstructorUsedError;
  Offset get center => throw _privateConstructorUsedError;
  double get innerRad => throw _privateConstructorUsedError;
  BlobSeed? get seed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobPointsCopyWith<BlobPoints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobPointsCopyWith<$Res> {
  factory $BlobPointsCopyWith(
          BlobPoints value, $Res Function(BlobPoints) then) =
      _$BlobPointsCopyWithImpl<$Res>;
  $Res call(
      {List<Offset> originPoints,
      List<Offset> destPoints,
      Offset center,
      double innerRad,
      BlobSeed? seed});

  $BlobSeedCopyWith<$Res>? get seed;
}

/// @nodoc
class _$BlobPointsCopyWithImpl<$Res> implements $BlobPointsCopyWith<$Res> {
  _$BlobPointsCopyWithImpl(this._value, this._then);

  final BlobPoints _value;
  // ignore: unused_field
  final $Res Function(BlobPoints) _then;

  @override
  $Res call({
    Object? originPoints = freezed,
    Object? destPoints = freezed,
    Object? center = freezed,
    Object? innerRad = freezed,
    Object? seed = freezed,
  }) {
    return _then(_value.copyWith(
      originPoints: originPoints == freezed
          ? _value.originPoints
          : originPoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      destPoints: destPoints == freezed
          ? _value.destPoints
          : destPoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      center: center == freezed
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
      innerRad: innerRad == freezed
          ? _value.innerRad
          : innerRad // ignore: cast_nullable_to_non_nullable
              as double,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed?,
    ));
  }

  @override
  $BlobSeedCopyWith<$Res>? get seed {
    if (_value.seed == null) {
      return null;
    }

    return $BlobSeedCopyWith<$Res>(_value.seed!, (value) {
      return _then(_value.copyWith(seed: value));
    });
  }
}

/// @nodoc
abstract class _$BlobPointsCopyWith<$Res> implements $BlobPointsCopyWith<$Res> {
  factory _$BlobPointsCopyWith(
          _BlobPoints value, $Res Function(_BlobPoints) then) =
      __$BlobPointsCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Offset> originPoints,
      List<Offset> destPoints,
      Offset center,
      double innerRad,
      BlobSeed? seed});

  @override
  $BlobSeedCopyWith<$Res>? get seed;
}

/// @nodoc
class __$BlobPointsCopyWithImpl<$Res> extends _$BlobPointsCopyWithImpl<$Res>
    implements _$BlobPointsCopyWith<$Res> {
  __$BlobPointsCopyWithImpl(
      _BlobPoints _value, $Res Function(_BlobPoints) _then)
      : super(_value, (v) => _then(v as _BlobPoints));

  @override
  _BlobPoints get _value => super._value as _BlobPoints;

  @override
  $Res call({
    Object? originPoints = freezed,
    Object? destPoints = freezed,
    Object? center = freezed,
    Object? innerRad = freezed,
    Object? seed = freezed,
  }) {
    return _then(_BlobPoints(
      originPoints: originPoints == freezed
          ? _value.originPoints
          : originPoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      destPoints: destPoints == freezed
          ? _value.destPoints
          : destPoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      center: center == freezed
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
      innerRad: innerRad == freezed
          ? _value.innerRad
          : innerRad // ignore: cast_nullable_to_non_nullable
              as double,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed?,
    ));
  }
}

/// @nodoc

class _$_BlobPoints implements _BlobPoints {
  const _$_BlobPoints(
      {required this.originPoints,
      required this.destPoints,
      required this.center,
      required this.innerRad,
      this.seed});

  @override
  final List<Offset> originPoints;
  @override
  final List<Offset> destPoints;
  @override
  final Offset center;
  @override
  final double innerRad;
  @override
  final BlobSeed? seed;

  @override
  String toString() {
    return 'BlobPoints(originPoints: $originPoints, destPoints: $destPoints, center: $center, innerRad: $innerRad, seed: $seed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobPoints &&
            (identical(other.originPoints, originPoints) ||
                const DeepCollectionEquality()
                    .equals(other.originPoints, originPoints)) &&
            (identical(other.destPoints, destPoints) ||
                const DeepCollectionEquality()
                    .equals(other.destPoints, destPoints)) &&
            (identical(other.center, center) ||
                const DeepCollectionEquality().equals(other.center, center)) &&
            (identical(other.innerRad, innerRad) ||
                const DeepCollectionEquality()
                    .equals(other.innerRad, innerRad)) &&
            (identical(other.seed, seed) ||
                const DeepCollectionEquality().equals(other.seed, seed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(originPoints) ^
      const DeepCollectionEquality().hash(destPoints) ^
      const DeepCollectionEquality().hash(center) ^
      const DeepCollectionEquality().hash(innerRad) ^
      const DeepCollectionEquality().hash(seed);

  @JsonKey(ignore: true)
  @override
  _$BlobPointsCopyWith<_BlobPoints> get copyWith =>
      __$BlobPointsCopyWithImpl<_BlobPoints>(this, _$identity);
}

abstract class _BlobPoints implements BlobPoints {
  const factory _BlobPoints(
      {required List<Offset> originPoints,
      required List<Offset> destPoints,
      required Offset center,
      required double innerRad,
      BlobSeed? seed}) = _$_BlobPoints;

  @override
  List<Offset> get originPoints => throw _privateConstructorUsedError;
  @override
  List<Offset> get destPoints => throw _privateConstructorUsedError;
  @override
  Offset get center => throw _privateConstructorUsedError;
  @override
  double get innerRad => throw _privateConstructorUsedError;
  @override
  BlobSeed? get seed => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobPointsCopyWith<_BlobPoints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BlobPaintDataTearOff {
  const _$BlobPaintDataTearOff();

  _BlobPaintData call(
      {required Size size,
      required BlobSeed seed,
      Alignment alignment = Alignment.center,
      Offset translation = Offset.zero,
      BlobStyle? style}) {
    return _BlobPaintData(
      size: size,
      seed: seed,
      alignment: alignment,
      translation: translation,
      style: style,
    );
  }
}

/// @nodoc
const $BlobPaintData = _$BlobPaintDataTearOff();

/// @nodoc
mixin _$BlobPaintData {
  Size get size => throw _privateConstructorUsedError;
  BlobSeed get seed => throw _privateConstructorUsedError;
  Alignment get alignment =>
      throw _privateConstructorUsedError; // Alignment of the painted blob rect on the canvas.
  Offset get translation =>
      throw _privateConstructorUsedError; // Shift of the path after the blob is aligned on the canvas.
  BlobStyle? get style => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BlobPaintDataCopyWith<BlobPaintData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlobPaintDataCopyWith<$Res> {
  factory $BlobPaintDataCopyWith(
          BlobPaintData value, $Res Function(BlobPaintData) then) =
      _$BlobPaintDataCopyWithImpl<$Res>;
  $Res call(
      {Size size,
      BlobSeed seed,
      Alignment alignment,
      Offset translation,
      BlobStyle? style});

  $BlobSeedCopyWith<$Res> get seed;
  $BlobStyleCopyWith<$Res>? get style;
}

/// @nodoc
class _$BlobPaintDataCopyWithImpl<$Res>
    implements $BlobPaintDataCopyWith<$Res> {
  _$BlobPaintDataCopyWithImpl(this._value, this._then);

  final BlobPaintData _value;
  // ignore: unused_field
  final $Res Function(BlobPaintData) _then;

  @override
  $Res call({
    Object? size = freezed,
    Object? seed = freezed,
    Object? alignment = freezed,
    Object? translation = freezed,
    Object? style = freezed,
  }) {
    return _then(_value.copyWith(
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed,
      alignment: alignment == freezed
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as Alignment,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as Offset,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as BlobStyle?,
    ));
  }

  @override
  $BlobSeedCopyWith<$Res> get seed {
    return $BlobSeedCopyWith<$Res>(_value.seed, (value) {
      return _then(_value.copyWith(seed: value));
    });
  }

  @override
  $BlobStyleCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $BlobStyleCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value));
    });
  }
}

/// @nodoc
abstract class _$BlobPaintDataCopyWith<$Res>
    implements $BlobPaintDataCopyWith<$Res> {
  factory _$BlobPaintDataCopyWith(
          _BlobPaintData value, $Res Function(_BlobPaintData) then) =
      __$BlobPaintDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Size size,
      BlobSeed seed,
      Alignment alignment,
      Offset translation,
      BlobStyle? style});

  @override
  $BlobSeedCopyWith<$Res> get seed;
  @override
  $BlobStyleCopyWith<$Res>? get style;
}

/// @nodoc
class __$BlobPaintDataCopyWithImpl<$Res>
    extends _$BlobPaintDataCopyWithImpl<$Res>
    implements _$BlobPaintDataCopyWith<$Res> {
  __$BlobPaintDataCopyWithImpl(
      _BlobPaintData _value, $Res Function(_BlobPaintData) _then)
      : super(_value, (v) => _then(v as _BlobPaintData));

  @override
  _BlobPaintData get _value => super._value as _BlobPaintData;

  @override
  $Res call({
    Object? size = freezed,
    Object? seed = freezed,
    Object? alignment = freezed,
    Object? translation = freezed,
    Object? style = freezed,
  }) {
    return _then(_BlobPaintData(
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as BlobSeed,
      alignment: alignment == freezed
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as Alignment,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as Offset,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as BlobStyle?,
    ));
  }
}

/// @nodoc

class _$_BlobPaintData extends _BlobPaintData {
  _$_BlobPaintData(
      {required this.size,
      required this.seed,
      this.alignment = Alignment.center,
      this.translation = Offset.zero,
      this.style})
      : super._();

  @override
  final Size size;
  @override
  final BlobSeed seed;
  @JsonKey(defaultValue: Alignment.center)
  @override
  final Alignment alignment;
  @JsonKey(defaultValue: Offset.zero)
  @override // Alignment of the painted blob rect on the canvas.
  final Offset translation;
  @override // Shift of the path after the blob is aligned on the canvas.
  final BlobStyle? style;

  @override
  String toString() {
    return 'BlobPaintData(size: $size, seed: $seed, alignment: $alignment, translation: $translation, style: $style)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BlobPaintData &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.seed, seed) ||
                const DeepCollectionEquality().equals(other.seed, seed)) &&
            (identical(other.alignment, alignment) ||
                const DeepCollectionEquality()
                    .equals(other.alignment, alignment)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)) &&
            (identical(other.style, style) ||
                const DeepCollectionEquality().equals(other.style, style)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(seed) ^
      const DeepCollectionEquality().hash(alignment) ^
      const DeepCollectionEquality().hash(translation) ^
      const DeepCollectionEquality().hash(style);

  @JsonKey(ignore: true)
  @override
  _$BlobPaintDataCopyWith<_BlobPaintData> get copyWith =>
      __$BlobPaintDataCopyWithImpl<_BlobPaintData>(this, _$identity);
}

abstract class _BlobPaintData extends BlobPaintData {
  factory _BlobPaintData(
      {required Size size,
      required BlobSeed seed,
      Alignment alignment,
      Offset translation,
      BlobStyle? style}) = _$_BlobPaintData;
  _BlobPaintData._() : super._();

  @override
  Size get size => throw _privateConstructorUsedError;
  @override
  BlobSeed get seed => throw _privateConstructorUsedError;
  @override
  Alignment get alignment => throw _privateConstructorUsedError;
  @override // Alignment of the painted blob rect on the canvas.
  Offset get translation => throw _privateConstructorUsedError;
  @override // Shift of the path after the blob is aligned on the canvas.
  BlobStyle? get style => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BlobPaintDataCopyWith<_BlobPaintData> get copyWith =>
      throw _privateConstructorUsedError;
}
