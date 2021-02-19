import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

extension colorExtension on Color {
  String _toHex() => this == Colors.transparent ? '#00ff0000' : '#${value.toRadixString(16)}';
}

class ColorHexConverter implements JsonConverter<Color, String> {
  const ColorHexConverter();

  @override
  Color fromJson(String json) => json != null ? Color(int.parse(json, radix: 16)) : null;

  @override
  String toJson(Color object) => object?._toHex();
}

class Uint8ListConverter implements JsonConverter<Uint8List, dynamic> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(dynamic json) => json != null && json is List<int> ? Uint8List.fromList(json) : null;

  @override
  dynamic toJson(Uint8List object) => object;
}

class EdgeInsetsConverter implements JsonConverter<EdgeInsets, Map> {
  const EdgeInsetsConverter();

  @override
  EdgeInsets fromJson(Map json) => json != null && json is Map
      ? EdgeInsets.only(
          left: json['left'] as double ?? 0.0,
          top: json['top'] as double ?? 0.0,
          right: json['right'] as double ?? 0.0,
          bottom: json['bottom'] as double ?? 0.0,
        )
      : null;

  @override
  Map toJson(EdgeInsets object) => object != null
      ? {
          'left': object.left,
          'top': object.top,
          'right': object.right,
          'bottom': object.bottom,
        }
      : null;
}

/// Expects to convert circular corners only.
class BorderRadiusConverter implements JsonConverter<BorderRadius, Map> {
  const BorderRadiusConverter();

  @override
  BorderRadius fromJson(Map json) => json != null && json is Map
      ? BorderRadius.only(
          topLeft: Radius.circular(json['topLeft'] as double ?? 0.0),
          topRight: Radius.circular(json['topRight'] as double ?? 0.0),
          bottomLeft: Radius.circular(json['bottomLeft'] as double ?? 0.0),
          bottomRight: Radius.circular(json['bottomRight'] as double ?? 0.0),
        )
      : null;

  @override
  Map toJson(BorderRadius object) => object != null
      ? {
          'topLeft': object.topLeft.x,
          'topRight': object.topRight.x,
          'bottomLeft': object.bottomLeft.x,
          'bottomRight': object.bottomRight.x,
        }
      : null;
}
