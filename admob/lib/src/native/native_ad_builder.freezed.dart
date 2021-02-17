// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'native_ad_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NativeAdPlatformViewProps _$NativeAdPlatformViewPropsFromJson(
    Map<String, dynamic> json) {
  return _NativeAdPlatformViewProps.fromJson(json);
}

/// @nodoc
class _$NativeAdPlatformViewPropsTearOff {
  const _$NativeAdPlatformViewPropsTearOff();

// ignore: unused_element
  _NativeAdPlatformViewProps call(
      {@required String controllerId, @required AdView view}) {
    return _NativeAdPlatformViewProps(
      controllerId: controllerId,
      view: view,
    );
  }

// ignore: unused_element
  NativeAdPlatformViewProps fromJson(Map<String, Object> json) {
    return NativeAdPlatformViewProps.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $NativeAdPlatformViewProps = _$NativeAdPlatformViewPropsTearOff();

/// @nodoc
mixin _$NativeAdPlatformViewProps {
  String get controllerId;
  AdView get view;

  Map<String, dynamic> toJson();
  $NativeAdPlatformViewPropsCopyWith<NativeAdPlatformViewProps> get copyWith;
}

/// @nodoc
abstract class $NativeAdPlatformViewPropsCopyWith<$Res> {
  factory $NativeAdPlatformViewPropsCopyWith(NativeAdPlatformViewProps value,
          $Res Function(NativeAdPlatformViewProps) then) =
      _$NativeAdPlatformViewPropsCopyWithImpl<$Res>;
  $Res call({String controllerId, AdView view});

  $AdViewCopyWith<$Res> get view;
}

/// @nodoc
class _$NativeAdPlatformViewPropsCopyWithImpl<$Res>
    implements $NativeAdPlatformViewPropsCopyWith<$Res> {
  _$NativeAdPlatformViewPropsCopyWithImpl(this._value, this._then);

  final NativeAdPlatformViewProps _value;
  // ignore: unused_field
  final $Res Function(NativeAdPlatformViewProps) _then;

  @override
  $Res call({
    Object controllerId = freezed,
    Object view = freezed,
  }) {
    return _then(_value.copyWith(
      controllerId: controllerId == freezed
          ? _value.controllerId
          : controllerId as String,
      view: view == freezed ? _value.view : view as AdView,
    ));
  }

  @override
  $AdViewCopyWith<$Res> get view {
    if (_value.view == null) {
      return null;
    }
    return $AdViewCopyWith<$Res>(_value.view, (value) {
      return _then(_value.copyWith(view: value));
    });
  }
}

/// @nodoc
abstract class _$NativeAdPlatformViewPropsCopyWith<$Res>
    implements $NativeAdPlatformViewPropsCopyWith<$Res> {
  factory _$NativeAdPlatformViewPropsCopyWith(_NativeAdPlatformViewProps value,
          $Res Function(_NativeAdPlatformViewProps) then) =
      __$NativeAdPlatformViewPropsCopyWithImpl<$Res>;
  @override
  $Res call({String controllerId, AdView view});

  @override
  $AdViewCopyWith<$Res> get view;
}

/// @nodoc
class __$NativeAdPlatformViewPropsCopyWithImpl<$Res>
    extends _$NativeAdPlatformViewPropsCopyWithImpl<$Res>
    implements _$NativeAdPlatformViewPropsCopyWith<$Res> {
  __$NativeAdPlatformViewPropsCopyWithImpl(_NativeAdPlatformViewProps _value,
      $Res Function(_NativeAdPlatformViewProps) _then)
      : super(_value, (v) => _then(v as _NativeAdPlatformViewProps));

  @override
  _NativeAdPlatformViewProps get _value =>
      super._value as _NativeAdPlatformViewProps;

  @override
  $Res call({
    Object controllerId = freezed,
    Object view = freezed,
  }) {
    return _then(_NativeAdPlatformViewProps(
      controllerId: controllerId == freezed
          ? _value.controllerId
          : controllerId as String,
      view: view == freezed ? _value.view : view as AdView,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_NativeAdPlatformViewProps
    with DiagnosticableTreeMixin
    implements _NativeAdPlatformViewProps {
  _$_NativeAdPlatformViewProps(
      {@required this.controllerId, @required this.view})
      : assert(controllerId != null),
        assert(view != null);

  factory _$_NativeAdPlatformViewProps.fromJson(Map<String, dynamic> json) =>
      _$_$_NativeAdPlatformViewPropsFromJson(json);

  @override
  final String controllerId;
  @override
  final AdView view;

  bool _didjson = false;
  Map<String, dynamic> _json;

  @override
  Map<String, dynamic> get json {
    if (_didjson == false) {
      _didjson = true;
      _json = toJson();
    }
    return _json;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NativeAdPlatformViewProps(controllerId: $controllerId, view: $view, json: $json)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NativeAdPlatformViewProps'))
      ..add(DiagnosticsProperty('controllerId', controllerId))
      ..add(DiagnosticsProperty('view', view))
      ..add(DiagnosticsProperty('json', json));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NativeAdPlatformViewProps &&
            (identical(other.controllerId, controllerId) ||
                const DeepCollectionEquality()
                    .equals(other.controllerId, controllerId)) &&
            (identical(other.view, view) ||
                const DeepCollectionEquality().equals(other.view, view)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(controllerId) ^
      const DeepCollectionEquality().hash(view);

  @override
  _$NativeAdPlatformViewPropsCopyWith<_NativeAdPlatformViewProps>
      get copyWith =>
          __$NativeAdPlatformViewPropsCopyWithImpl<_NativeAdPlatformViewProps>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NativeAdPlatformViewPropsToJson(this);
  }
}

abstract class _NativeAdPlatformViewProps implements NativeAdPlatformViewProps {
  factory _NativeAdPlatformViewProps(
      {@required String controllerId,
      @required AdView view}) = _$_NativeAdPlatformViewProps;

  factory _NativeAdPlatformViewProps.fromJson(Map<String, dynamic> json) =
      _$_NativeAdPlatformViewProps.fromJson;

  @override
  String get controllerId;
  @override
  AdView get view;
  @override
  _$NativeAdPlatformViewPropsCopyWith<_NativeAdPlatformViewProps> get copyWith;
}

/// @nodoc
class _$NativeAdViewHolderTearOff {
  const _$NativeAdViewHolderTearOff();

// ignore: unused_element
  _NativeAdViewHolder call(
      {AdTextView advertiser,
      AdTextView attribution,
      AdTextView body,
      AdTextView headline,
      AdButtonView button,
      AdImageView icon,
      AdMediaView media,
      AdTextView price,
      AdTextView store,
      AdRatingBarView ratingBar}) {
    return _NativeAdViewHolder(
      advertiser: advertiser,
      attribution: attribution,
      body: body,
      headline: headline,
      button: button,
      icon: icon,
      media: media,
      price: price,
      store: store,
      ratingBar: ratingBar,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NativeAdViewHolder = _$NativeAdViewHolderTearOff();

/// @nodoc
mixin _$NativeAdViewHolder {
  AdTextView get advertiser;
  AdTextView get attribution;
  AdTextView get body;
  AdTextView get headline;
  AdButtonView get button;
  AdImageView get icon;
  AdMediaView get media;
  AdTextView get price;
  AdTextView get store;
  AdRatingBarView get ratingBar;

  $NativeAdViewHolderCopyWith<NativeAdViewHolder> get copyWith;
}

/// @nodoc
abstract class $NativeAdViewHolderCopyWith<$Res> {
  factory $NativeAdViewHolderCopyWith(
          NativeAdViewHolder value, $Res Function(NativeAdViewHolder) then) =
      _$NativeAdViewHolderCopyWithImpl<$Res>;
  $Res call(
      {AdTextView advertiser,
      AdTextView attribution,
      AdTextView body,
      AdTextView headline,
      AdButtonView button,
      AdImageView icon,
      AdMediaView media,
      AdTextView price,
      AdTextView store,
      AdRatingBarView ratingBar});
}

/// @nodoc
class _$NativeAdViewHolderCopyWithImpl<$Res>
    implements $NativeAdViewHolderCopyWith<$Res> {
  _$NativeAdViewHolderCopyWithImpl(this._value, this._then);

  final NativeAdViewHolder _value;
  // ignore: unused_field
  final $Res Function(NativeAdViewHolder) _then;

  @override
  $Res call({
    Object advertiser = freezed,
    Object attribution = freezed,
    Object body = freezed,
    Object headline = freezed,
    Object button = freezed,
    Object icon = freezed,
    Object media = freezed,
    Object price = freezed,
    Object store = freezed,
    Object ratingBar = freezed,
  }) {
    return _then(_value.copyWith(
      advertiser:
          advertiser == freezed ? _value.advertiser : advertiser as AdTextView,
      attribution: attribution == freezed
          ? _value.attribution
          : attribution as AdTextView,
      body: body == freezed ? _value.body : body as AdTextView,
      headline: headline == freezed ? _value.headline : headline as AdTextView,
      button: button == freezed ? _value.button : button as AdButtonView,
      icon: icon == freezed ? _value.icon : icon as AdImageView,
      media: media == freezed ? _value.media : media as AdMediaView,
      price: price == freezed ? _value.price : price as AdTextView,
      store: store == freezed ? _value.store : store as AdTextView,
      ratingBar: ratingBar == freezed
          ? _value.ratingBar
          : ratingBar as AdRatingBarView,
    ));
  }
}

/// @nodoc
abstract class _$NativeAdViewHolderCopyWith<$Res>
    implements $NativeAdViewHolderCopyWith<$Res> {
  factory _$NativeAdViewHolderCopyWith(
          _NativeAdViewHolder value, $Res Function(_NativeAdViewHolder) then) =
      __$NativeAdViewHolderCopyWithImpl<$Res>;
  @override
  $Res call(
      {AdTextView advertiser,
      AdTextView attribution,
      AdTextView body,
      AdTextView headline,
      AdButtonView button,
      AdImageView icon,
      AdMediaView media,
      AdTextView price,
      AdTextView store,
      AdRatingBarView ratingBar});
}

/// @nodoc
class __$NativeAdViewHolderCopyWithImpl<$Res>
    extends _$NativeAdViewHolderCopyWithImpl<$Res>
    implements _$NativeAdViewHolderCopyWith<$Res> {
  __$NativeAdViewHolderCopyWithImpl(
      _NativeAdViewHolder _value, $Res Function(_NativeAdViewHolder) _then)
      : super(_value, (v) => _then(v as _NativeAdViewHolder));

  @override
  _NativeAdViewHolder get _value => super._value as _NativeAdViewHolder;

  @override
  $Res call({
    Object advertiser = freezed,
    Object attribution = freezed,
    Object body = freezed,
    Object headline = freezed,
    Object button = freezed,
    Object icon = freezed,
    Object media = freezed,
    Object price = freezed,
    Object store = freezed,
    Object ratingBar = freezed,
  }) {
    return _then(_NativeAdViewHolder(
      advertiser:
          advertiser == freezed ? _value.advertiser : advertiser as AdTextView,
      attribution: attribution == freezed
          ? _value.attribution
          : attribution as AdTextView,
      body: body == freezed ? _value.body : body as AdTextView,
      headline: headline == freezed ? _value.headline : headline as AdTextView,
      button: button == freezed ? _value.button : button as AdButtonView,
      icon: icon == freezed ? _value.icon : icon as AdImageView,
      media: media == freezed ? _value.media : media as AdMediaView,
      price: price == freezed ? _value.price : price as AdTextView,
      store: store == freezed ? _value.store : store as AdTextView,
      ratingBar: ratingBar == freezed
          ? _value.ratingBar
          : ratingBar as AdRatingBarView,
    ));
  }
}

/// @nodoc
class _$_NativeAdViewHolder
    with DiagnosticableTreeMixin
    implements _NativeAdViewHolder {
  const _$_NativeAdViewHolder(
      {this.advertiser,
      this.attribution,
      this.body,
      this.headline,
      this.button,
      this.icon,
      this.media,
      this.price,
      this.store,
      this.ratingBar});

  @override
  final AdTextView advertiser;
  @override
  final AdTextView attribution;
  @override
  final AdTextView body;
  @override
  final AdTextView headline;
  @override
  final AdButtonView button;
  @override
  final AdImageView icon;
  @override
  final AdMediaView media;
  @override
  final AdTextView price;
  @override
  final AdTextView store;
  @override
  final AdRatingBarView ratingBar;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NativeAdViewHolder(advertiser: $advertiser, attribution: $attribution, body: $body, headline: $headline, button: $button, icon: $icon, media: $media, price: $price, store: $store, ratingBar: $ratingBar)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NativeAdViewHolder'))
      ..add(DiagnosticsProperty('advertiser', advertiser))
      ..add(DiagnosticsProperty('attribution', attribution))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('headline', headline))
      ..add(DiagnosticsProperty('button', button))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('media', media))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('store', store))
      ..add(DiagnosticsProperty('ratingBar', ratingBar));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NativeAdViewHolder &&
            (identical(other.advertiser, advertiser) ||
                const DeepCollectionEquality()
                    .equals(other.advertiser, advertiser)) &&
            (identical(other.attribution, attribution) ||
                const DeepCollectionEquality()
                    .equals(other.attribution, attribution)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.headline, headline) ||
                const DeepCollectionEquality()
                    .equals(other.headline, headline)) &&
            (identical(other.button, button) ||
                const DeepCollectionEquality().equals(other.button, button)) &&
            (identical(other.icon, icon) ||
                const DeepCollectionEquality().equals(other.icon, icon)) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.store, store) ||
                const DeepCollectionEquality().equals(other.store, store)) &&
            (identical(other.ratingBar, ratingBar) ||
                const DeepCollectionEquality()
                    .equals(other.ratingBar, ratingBar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(advertiser) ^
      const DeepCollectionEquality().hash(attribution) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(headline) ^
      const DeepCollectionEquality().hash(button) ^
      const DeepCollectionEquality().hash(icon) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(store) ^
      const DeepCollectionEquality().hash(ratingBar);

  @override
  _$NativeAdViewHolderCopyWith<_NativeAdViewHolder> get copyWith =>
      __$NativeAdViewHolderCopyWithImpl<_NativeAdViewHolder>(this, _$identity);
}

abstract class _NativeAdViewHolder implements NativeAdViewHolder {
  const factory _NativeAdViewHolder(
      {AdTextView advertiser,
      AdTextView attribution,
      AdTextView body,
      AdTextView headline,
      AdButtonView button,
      AdImageView icon,
      AdMediaView media,
      AdTextView price,
      AdTextView store,
      AdRatingBarView ratingBar}) = _$_NativeAdViewHolder;

  @override
  AdTextView get advertiser;
  @override
  AdTextView get attribution;
  @override
  AdTextView get body;
  @override
  AdTextView get headline;
  @override
  AdButtonView get button;
  @override
  AdImageView get icon;
  @override
  AdMediaView get media;
  @override
  AdTextView get price;
  @override
  AdTextView get store;
  @override
  AdRatingBarView get ratingBar;
  @override
  _$NativeAdViewHolderCopyWith<_NativeAdViewHolder> get copyWith;
}
