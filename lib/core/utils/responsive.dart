import 'package:flutter/material.dart';

class Responsive {
  static const double designWidth = 402.0;
  static const double designHeight = 874.0;

  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  // Scale factor based on screen width (with constraints to prevent distortion)
  static double scale(BuildContext context) {
    final double screenWidth = width(context);
    final double constrainedWidth = screenWidth > 500 ? 500 : screenWidth;
    return (constrainedWidth / designWidth).clamp(0.85, 1.25);
  }

  // Proportional width calculation
  static double w(BuildContext context, double value) {
    return value * scale(context);
  }

  // Proportional height / spacing
  static double h(BuildContext context, double value) {
    final double screenHeight = height(context);
    final double scaleY = (screenHeight / designHeight).clamp(0.85, 1.25);
    return value * scaleY;
  }

  // Responsive font size
  static double sp(BuildContext context, double fontSize) {
    return fontSize * scale(context);
  }

  // Maximum content width for tablet / desktop layouts
  static const double maxContentWidth = 450.0;
}
