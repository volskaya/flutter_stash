// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NativeAdController on _NativeAdController, Store {
  final _$nativeAdAtom = Atom(name: '_NativeAdController.nativeAd');

  @override
  NativeAd get nativeAd {
    _$nativeAdAtom.reportRead();
    return super.nativeAd;
  }

  @override
  set nativeAd(NativeAd value) {
    if (super.nativeAd != value) {
      _$nativeAdAtom.reportWrite(value, super.nativeAd, () {
        super.nativeAd = value;
      });
    }
  }

  final _$videoStateAtom = Atom(name: '_NativeAdController.videoState');

  @override
  NativeAdVideoState get videoState {
    _$videoStateAtom.reportRead();
    return super.videoState;
  }

  @override
  set videoState(NativeAdVideoState value) {
    if (super.videoState != value) {
      _$videoStateAtom.reportWrite(value, super.videoState, () {
        super.videoState = value;
      });
    }
  }

  final _$muteThisAdReasonsAtom =
      Atom(name: '_NativeAdController.muteThisAdReasons');

  @override
  List<String> get muteThisAdReasons {
    _$muteThisAdReasonsAtom.reportRead();
    return super.muteThisAdReasons;
  }

  @override
  set muteThisAdReasons(List<String> value) {
    if (super.muteThisAdReasons != value) {
      _$muteThisAdReasonsAtom.reportWrite(value, super.muteThisAdReasons, () {
        super.muteThisAdReasons = value;
      });
    }
  }

  @override
  String toString() {
    return '''
nativeAd: ${nativeAd},
videoState: ${videoState},
muteThisAdReasons: ${muteThisAdReasons}
    ''';
  }
}
