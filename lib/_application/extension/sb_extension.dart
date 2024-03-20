import "package:flutter/material.dart";

extension SizeBoxExtension on int {
  /// Sizebox width
  SizedBox get horizontal => SizedBox(width: toDouble());

  /// Sizebox height
  SizedBox get vertical => SizedBox(height: toDouble());
}

extension SizeBoxWidgetExtension on Widget {
  /// Sizebox width with widget
  Widget horizontal(double horizontal) => SizedBox(
        width: horizontal,
        child: this,
      );

  /// Sizebox height with widget
  Widget vertical(double vertical) => SizedBox(
        height: vertical,
        child: this,
      );
}
