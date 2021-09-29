// import 'package:animations/src/compound_transition_animation/compound_transition_animation.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:freezed_annotation/freezed_annotation.dart';

// // part 'shared_axis_compound_transition_animation.freezed.dart';

// class HorizontalSACTValue extends CompoundTransitionValue<HorizontalSACTValue> {
//   const HorizontalSACTValue({
//     required this.opacity,
//     required this.translation,
//   });

//   final double opacity;
//   final Offset translation;

//   @override
//   HorizontalSACTValue operator +(HorizontalSACTValue other) {
//     return HorizontalSACTValue(
//       opacity: (opacity + other.opacity) / 2.0,
//       translation: translation + other.translation,
//     );
//   }
// }

// class HorizontalSACTCurves extends Animatable<HorizontalSACTValue> {
//   HorizontalSACTCurves({
//     required this.opacity,
//     required this.translation,
//   });

//   final Animatable<double> opacity;
//   final Animatable<Offset> translation;

//   @override
//   HorizontalSACTValue transform(double t) {
//     return HorizontalSACTValue(
//       opacity: opacity.transform(t),
//       translation: translation.transform(t),
//     );
//   }
// }

// class VerticalSACTValue extends CompoundTransitionValue<VerticalSACTValue> {
//   const VerticalSACTValue({
//     required this.opacity,
//     required this.translation,
//   });

//   final double opacity;
//   final Offset translation;

//   @override
//   VerticalSACTValue operator +(VerticalSACTValue other) {
//     return VerticalSACTValue(
//       opacity: (opacity + other.opacity) / 2.0,
//       translation: translation + other.translation,
//     );
//   }
// }

// class VerticalSACTCurves extends Animatable<VerticalSACTValue> {
//   VerticalSACTCurves({
//     required this.opacity,
//     required this.translation,
//   });

//   final Animatable<double> opacity;
//   final Animatable<Offset> translation;

//   @override
//   VerticalSACTValue transform(double t) {
//     return VerticalSACTValue(
//       opacity: opacity.transform(t),
//       translation: translation.transform(t),
//     );
//   }
// }

// class ScaledSACTValue extends CompoundTransitionValue<ScaledSACTValue> {
//   const ScaledSACTValue({
//     required this.opacity,
//     required this.scale,
//   });

//   final double opacity;
//   final double scale;

//   @override
//   ScaledSACTValue operator +(ScaledSACTValue other) {
//     return ScaledSACTValue(
//       opacity: (opacity + other.opacity) / 2.0,
//       scale: (scale + other.scale) / 2.0,
//     );
//   }
// }

// class ScaledSACTCurves extends Animatable<ScaledSACTValue> {
//   ScaledSACTCurves({
//     required this.opacity,
//     required this.scale,
//   });

//   final Animatable<double> opacity;
//   final Animatable<double> scale;

//   @override
//   ScaledSACTValue transform(double t) {
//     return ScaledSACTValue(
//       opacity: opacity.transform(t),
//       scale: scale.transform(t),
//     );
//   }
// }

// // @freezed
// // class SharedAxisCompoundTransitionCurves extends Animatable<SharedAxisCompoundTransitionValue>
// //     with _$SharedAxisCompoundTransitionCurves {
// //   const factory SharedAxisCompoundTransitionCurves.horizontal({
// //     required Animatable<double> opacity,
// //     required Animatable<Offset> translation,
// //   }) = HorizontalSharedAxisCompoundTransitionCurves;

// //   const factory SharedAxisCompoundTransitionCurves.vertical({
// //     required Animatable<double> opacity,
// //     required Animatable<Offset> translation,
// //   }) = VerticalSharedAxisCompoundTransitionCurves;

// //   const factory SharedAxisCompoundTransitionCurves.scaled({
// //     required Animatable<double> opacity,
// //     required Animatable<double> scale,
// //   }) = ScaledSharedAxisCompoundTransitionCurves;

// //   const SharedAxisCompoundTransitionCurves._();

// //   @override
// //   SharedAxisCompoundTransitionValue transform(double t) => map(
// //         horizontal: (v) => SharedAxisCompoundTransitionValue.horizontal(
// //           opacity: v.opacity.transform(t),
// //           translation: v.translation.transform(t),
// //         ),
// //         vertical: (v) => SharedAxisCompoundTransitionValue.vertical(
// //           opacity: v.opacity.transform(t),
// //           translation: v.translation.transform(t),
// //         ),
// //         scaled: (v) => SharedAxisCompoundTransitionValue.scaled(
// //           opacity: v.opacity.transform(t),
// //           scale: v.scale.transform(t),
// //         ),
// //       );
// // }

// // @freezed
// // class SharedAxisCompoundTransitionValue extends CompoundTransitionValue<SharedAxisCompoundTransitionValue>
// //     with _$SharedAxisCompoundTransitionValue {
// //   const factory SharedAxisCompoundTransitionValue.horizontal({
// //     required double opacity,
// //     required Offset translation,
// //   }) = HorizontalSharedAxisCompoundTransitionValue;

// //   const factory SharedAxisCompoundTransitionValue.vertical({
// //     required double opacity,
// //     required Offset translation,
// //   }) = VerticalSharedAxisCompoundTransitionValue;

// //   const factory SharedAxisCompoundTransitionValue.scaled({
// //     required double opacity,
// //     required double scale,
// //   }) = ScaledSharedAxisCompoundTransitionValue;

// //   @override
// //   SharedAxisCompoundTransitionValue operator +(SharedAxisCompoundTransitionValue other) {
// //     assert(runtimeType == other.runtimeType);

// //     return map(
// //       horizontal: (v) {
// //         return SharedAxisCompoundTransitionValue.horizontal(
// // //..
// //             );
// //       },
// //       vertical: vertical,
// //       scaled: scaled,
// //     );
// //   }
// // }
