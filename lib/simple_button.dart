import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final List<Color> gradientColors;
  final String text;
  final TextStyle textStyle;
  final Function onPressed;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  const SimpleButton({
    Key key,
    this.height,
    this.width,
    this.color = Colors.black12,
    this.gradientColors,
    this.text,
    this.onPressed,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.padding = const EdgeInsets.all(3),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? height ?? 16 / 2),
        border: Border.all(width: borderWidth, color: borderColor),
        gradient: _gradient(),
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? height ?? 16 / 2),
        ),
        fillColor: _bgColor(),
        elevation: 0.0,
        onPressed: onPressed,
        padding: padding,
        child: Text(
          text ?? '',
          style: textStyle,
        ),
      ),
    );
  }

  bool get isActiveGradient =>
      gradientColors != null && gradientColors.length >= 2;

  Color _bgColor() {
    if (isActiveGradient) {
      return null;
    }
    if (color == null) {
      return Colors.black12;
    }
    return color;
  }

  Gradient _gradient() {
    if (isActiveGradient) {
      return LinearGradient(
        colors: gradientColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
    return null;
  }
}
